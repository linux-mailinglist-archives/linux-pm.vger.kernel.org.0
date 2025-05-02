Return-Path: <linux-pm+bounces-26572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E0AA748D
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19960179F7C
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672382566D1;
	Fri,  2 May 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YD0FCrbz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592C255F5E
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195100; cv=none; b=Z555jzZRVvUYKJmPwkgfrWJcTf0DlViLGWw0EyUVe92Qa5cXwb1Q/UND+K2UiJjVrKVwxwwmBk388712DZfEysbriR78ElgkY/jgPAdFMTzviJsr2DGe95YSS3aq7Wkoq7M+2GHzfDPESt4oomYK1iUcCefHV89bRG+JXi/eSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195100; c=relaxed/simple;
	bh=yIxrVkU4SFQ66DwToqGuNlKqd5dY6/8jM/wyRARXfyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxuP3R4oAZGhh8zDdppe6TroUroO2m8QiArK25/THBFBkc+lkSaOXIK7boL8Y74a3eUyYWKwtMqM8mlh4NGs5imvXmfQfFv0Xx3aeLvDUNqD+kb+1VeSUIjm3Hfa/HcKK3nSlsnEhrPkf4KkG7jiiHy2JuQz3fWTKrpi+VG/5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YD0FCrbz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac339f53df9so439733866b.1
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746195096; x=1746799896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yIxrVkU4SFQ66DwToqGuNlKqd5dY6/8jM/wyRARXfyA=;
        b=YD0FCrbzKXq2+J2x4Rcme2ozK3eFo4u0VIcHUYKLCvz4iNR79O8ClYduTKwRNcyqaw
         bXfiWU/HISaRQTGl3+5YiTH8Bn+C/UA3AfmXKSAZhQGqC3w2yI7tWHr8Erm2y68sfehE
         spUNbVK2CCXox3mX3/cjje+6fCpKZ+OFr57nh02U9astSB86upmsB9tQ6Ah7WVJ0gnuB
         Zk+UoNj2VfPGePA18Gq9mklX40U3NKRmbWrYI93hWENAlxFN1uFh89syUJA295cyrN36
         Gi7qUZfun+1RCkxTjX0potqKDlk1mwNhLmrdS5btewlFex6spsP2zqpBafPZ2RIKURBm
         HmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746195096; x=1746799896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIxrVkU4SFQ66DwToqGuNlKqd5dY6/8jM/wyRARXfyA=;
        b=BsMXfhN0YaXAiH8MVim1TzpdU0RhnBGR1+ax1N2gk9azMg+CN7G6BjEuQ8i6sflxYe
         5uiKQzCxk15mg0MQ5b9b8q15Y65iF2qCfDxH51EqBmKy8jlgvfVNwVw7SArokJ066GKw
         6rT2RjqtgrShdiG5q791SNvzY0+UrF4nQz8gFVgi92xbRMdsvrsmoW1toVBoxJxUn7cX
         vc39h7SdL8RH/C+2+n7/ytBmLwCKSY6NHftFVYgWiMnUh2g5yTdZKoxFfgV6BjX1RnWJ
         g6B0GeoHm6H8PIR2ll85l/4zuhNH35/x2U443kNJ2XM6rZNtx6/z3uW4nH61kRpQSqKn
         nUsA==
X-Forwarded-Encrypted: i=1; AJvYcCXKEOL2NxmlToOeBOs5W42a8ibTbooJnMuF2K4v2gAv4C8DEG2flBhCulBwDAip6nyvHOHIjME74Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39w8ZxenyaMxkLAoltYXNdTO9EPqL16em5rUj8IAI7t3eG3A2
	69PCrom2byr2bBJqcKogtWPZB9C5a9TNz+bYGQiYbKtZofTxzeO5v2m9oUOIbrbnkfLo4OoUcxG
	3JXu4IYv3VCi9fXvSDyGRVcSkoAqS3slpQDZmkA==
X-Gm-Gg: ASbGncvtDf8f/73WMSP28hBMsIdJRAMDJyjc3G4TLVxpnyw5o93lbxkazdfM8e311ZE
	ohrZCNsI9cJylsPlpvdUAjkmXHznqyKRw8PtkqQ/zeLmg3oE/5c/ADuFP6cJCSgJzfaTPpouxe/
	BJFxwvGEu1zjAMZzke2HXucnP9dPuBrtH2
X-Google-Smtp-Source: AGHT+IEs1bTD91IQNhCNs2cmGXwwVdvucdgeJR3evc2FFZN3RtZBiPjhHMCBSyUR5aj84pE2Qt2l2g6KYv7IB3kEAbQ=
X-Received: by 2002:a17:907:74a:b0:acf:15d:2387 with SMTP id
 a640c23a62f3a-ad17ada7132mr329262566b.19.1746195095856; Fri, 02 May 2025
 07:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com> <20250502053758.utawzhq6famwenc2@vireshk-i7>
 <8ba02745-378b-4264-883a-b99764701d0b@quicinc.com> <20250502081402.yjagnnjrfva7u4cb@vireshk-i7>
 <e1b2029b-2461-4cfc-a6b3-acdf5e01c289@quicinc.com>
In-Reply-To: <e1b2029b-2461-4cfc-a6b3-acdf5e01c289@quicinc.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 2 May 2025 19:41:24 +0530
X-Gm-Features: ATxdqUFgSe5sdPhV4tcbtGto6wWWIR8JrD77D7tcOXpnzioIpQJVJvx6MOBRrS4
Message-ID: <CAKohpondRqdfqC3CFSJibL2om8_Bbds8k5Dfu8fcZDksNxQUwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, psodagud@quicinc.com, 
	djaggi@quicinc.com, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com, 
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com, 
	quic_shazhuss@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 19:32, Praveen Talari <quic_ptalari@quicinc.com> wrote:
> now i can push V4 right and will not face errors on my series w.r.t this
> API.

Not fully sure what you meant, but you can send a V4 of the series,
without the first patch. Please mention it as an dependency in the
cover letter and that it is applied in the OPP tree's linux-next branch.

The one who applies your series needs to apply the series over the commit
in my branch to avoid breakage (if your series is going in 6.16-rc1).

--
Viresh

