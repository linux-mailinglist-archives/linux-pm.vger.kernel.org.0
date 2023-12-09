Return-Path: <linux-pm+bounces-852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0361D80B3C4
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 11:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339BC1C20A2F
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C83134C6;
	Sat,  9 Dec 2023 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq450Yr8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E1199D;
	Sat,  9 Dec 2023 02:44:42 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so35297901fa.3;
        Sat, 09 Dec 2023 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702118678; x=1702723478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY7ynBKPCSeJfUZQZBziVZS8J/xhhHax9vME1HSQU9M=;
        b=Vq450Yr8AhuQriLOKkXePhLZgZv8l7Hi8izAAJH7fjCfPZA+Ayaq2KhGvssoyBMvnv
         R/ceN03jFh8NG0a6rZkAcLe9PTWKohA8RYESgT2oNL5kQlxit2iZQMECg6TIoE+byTqn
         BQ/g+rtAWFTmOaiaBl+bQqL3p+S4RNlwsj8raxDmLjuKtvr2i/1lkKoHn43K9CzM0YwU
         o7M5gAAUSVQ1L36Xtqm2qnuAulgB5w11IooQEjslYUEUxA14GM7LTXWt5zJq4s5VoSZc
         5t6wU4R21DY85ZWpd1pHW8rQgFH6gQr5f//D0mRhojfmJyAOSF6daT9KUdZ3ZWnWy0To
         MBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118678; x=1702723478;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fY7ynBKPCSeJfUZQZBziVZS8J/xhhHax9vME1HSQU9M=;
        b=UUl/AwF0j2s2URU2KvqnnXrRaYyT12Gt6IP8sWDX9/+fnDyV/v131/fsdwKn89dxKa
         rZFwjCQjgM/Ix1d2JbYOlH10mhu7sQMbuGZvbDh0Xms+vOK7BSg4X21P17xAggnt1ajg
         l1UW4rnBK9kgwv1A0xlFX3gwGxD1seE6e4X6klzfFqyyIdGjifBig8mC0bsK1K6gcCbg
         XCiOcVY6aZFnszr2TYycEcqtx8ydpySR2CyvAQ5hxHqDwyvI/TgX38rGO73XAldghzba
         7JXGjltimZ+aqJqWPgExv9Xmx5o/5ZcBT0wn4sUNegh4soapMEN4R+ngCDopjrAQkMuv
         nl+Q==
X-Gm-Message-State: AOJu0YyZI9Kl+O/by8r4NQTQek5vKI5t+hU3hkrlEQdnYRM3b6/3cSf3
	SQj9x82Ly6pQmzIXg8ZmAl/ujutYVG0l6A==
X-Google-Smtp-Source: AGHT+IHYZjIB1wJvL8lKDSCDZ8BXV1l4fGj/CoOHxnNQO3v4GvEl1z2p/Vj2wIM4TEyWr5g50Pq3Vg==
X-Received: by 2002:a2e:9856:0:b0:2ca:16d0:9e9a with SMTP id e22-20020a2e9856000000b002ca16d09e9amr325815ljj.92.1702118678297;
        Sat, 09 Dec 2023 02:44:38 -0800 (PST)
Received: from [192.168.100.36] ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id 20-20020a2eb954000000b002c9f62145f8sm519334ljs.82.2023.12.09.02.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 02:44:37 -0800 (PST)
Message-ID: <a14fb458-caf0-4a4a-b76b-c2503b0840d2@gmail.com>
Date: Sat, 9 Dec 2023 13:44:34 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: andre.przywara@arm.com
Cc: anarsoul@gmail.com, bob@electricworry.net, conor+dt@kernel.org,
 daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-sunxi@lists.linux.dev, lukasz.luba@arm.com,
 martin.botka@somainline.org, rafael@kernel.org, robh+dt@kernel.org,
 rui.zhang@intel.com, samuel@sholland.org, tiny.windzz@gmail.com,
 wens@csie.org
References: <20231128005849.19044-6-andre.przywara@arm.com>
Subject: Re: [PATCH v3 5/6] thermal: sun8i: add support for H616 THS
 controller
Content-Language: en-US
From: Maksim Kiselev <bigunclemax@gmail.com>
In-Reply-To: <20231128005849.19044-6-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin, Andre.

May I inquire? Why do we need a separate sun50i_h616_ths_calibrate() 
function? Why can't we just extend an existing sun50i_h6_ths_calibrate()?

At my glance the calculations in both functions are the same. We just 
need to handle a special case for the 4th sensor.

Best regards,
Maksim


