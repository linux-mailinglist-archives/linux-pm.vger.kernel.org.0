Return-Path: <linux-pm+bounces-5541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8288F0DE
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 22:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7861D1C2D3CC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B2153579;
	Wed, 27 Mar 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9ez/RJs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1D153509;
	Wed, 27 Mar 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574734; cv=none; b=jnVYXu80Wdo3K7LLng2DMK8U4gd7owgFGthg95WJ2LuV6/WfYysOoPl60Evfg91Cn/PG4Gu43NzvwBFmflETMSK/p3ZqR2z/cSIOt/A2mabjXDxvGICDVJbqeTlUZ5VTAsy2MsBlNk667PUxunBlRb/VJDFbh8BxfWN5gdgg7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574734; c=relaxed/simple;
	bh=A3R7PORTOH1ZCk4+Ren4bGvSagTday2Ecp9Q6GNz3ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7W9P/bgO+G73diMQ4UwUq+EP0dGUSk6bbWXHbjrg20HgF3MGqoQSr8CfW6hng6bbA0sIuUpBQ565qCpotrQrMdbiamcGvadEoI+FXKlmP0QUZs1pXOJoeldr5WF8xpN4qO6IoY62ConV0XTLUCc6Sn7GWgp8QWJCKbCB99hUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9ez/RJs; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d485886545so3643871fa.2;
        Wed, 27 Mar 2024 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711574731; x=1712179531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un4R7YLsM9/K8j+g6A4JR2jGUE6474s5RDHi5cMWT2Q=;
        b=S9ez/RJsNvpahApVwnzhX7F8KLiAJcTVKxnCMQOqXiCWbwhiy859pJiOFjmjFgLeKj
         JT2pwJKfYf8ItkjPF/e/ziCnexsZshxeGTXR2W4nefmffKYpI1IxUKm8fOUMEzO0uyDC
         QZt02xZA3Jmybga31pO09FAZ7tGKK4xKgKki0dUpPSPMqOqWV/wUQt5pO4A1/rbvqZHm
         9FkddGkkn8ppmTeB8YxkseGlJlF7oeuDy3MU2NPACGwTT4cwBS8PS7v7Bi4Ov0EvdhmK
         tFh1aWD985rHJkTcFj6FEW/6lK2PlCN7udE7QRBhgYJrBnKfG0RYel9mVZqSrPSfY+1K
         HaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711574731; x=1712179531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un4R7YLsM9/K8j+g6A4JR2jGUE6474s5RDHi5cMWT2Q=;
        b=AnHTUXIe/s59GjjWEY0fjygdGt9Tx9jfs/7xMpBeHq5U0yrjog16yz01fFVcWJwGUP
         i3SpD2Zpq9xlhzDck8JIqoSUY6cL15426kQ3KSvwty33kW3+gAFQ5xkFiv+a/YSWINDm
         Z48zbdQC5LtWYciXtJp+p41cGMaXsFoKNG+XFUWVSCnhk4cbmi4OZQSKrpqqwQIorYPI
         PXnRIRSp7T7GFB9VK+zbFmNPHMa6/snCC8ZE9fD1ddcDi1D5594B22s+ki7a9WHW2pXy
         4dArWh56IzsSxxB0J4wFemiNP46h4OyvEzVzV8GId+AdwsulxfRwG4Jb4GfFNnHu/+tX
         pSfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqXlDaR7M8KMBZj2owz0/6E1C9VgBm5n4ioHkpeyJ4FdIvmgzPzlUBNwQ9OF3SsAMskkv+YwgDl9u3ECoHmouOUyKaCci857Dr8A==
X-Gm-Message-State: AOJu0YwRv169gxLgi8srnV4pQI9fbZIBngs5xjNgLnnlihVkfSwKr6+U
	AqWAyt7u5axbyLfWmSADSDhLHn8cC1BE9WuvBL14wciUbJ04Ahs1
X-Google-Smtp-Source: AGHT+IHSs1wyNGCnTL05qgATrXG35KaRRYLaTCf2rV+bI+5PydNNMRMDZ52wyDVUp3UeCi0XSJDrSQ==
X-Received: by 2002:a2e:700f:0:b0:2d6:f372:aba7 with SMTP id l15-20020a2e700f000000b002d6f372aba7mr1178231ljc.39.1711574730538;
        Wed, 27 Mar 2024 14:25:30 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709061c9900b00a46a71c5324sm5858042ejh.34.2024.03.27.14.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:25:30 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>,
 Chris Morgan <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>
Subject:
 Re: [PATCH v3 8/8] arm64: dts: allwinner: h616: enable DVFS for all boards
Date: Wed, 27 Mar 2024 22:25:28 +0100
Message-ID: <2381735.NG923GbCHz@jernej-laptop>
In-Reply-To: <20240326114743.712167-9-andre.przywara@arm.com>
References:
 <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-9-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 26. marec 2024 ob 12:47:43 CET je Andre Przywara napisal(a):
> With the DT bindings now describing the format of the CPU OPP tables, we
> can include the OPP table in each board's .dts file, and specify the CPU
> power supply.
> This allows to enable DVFS, and get up to 50% of performance benefit in
> the highest OPP, or up to 60% power savings in the lowest OPP, compared
> to the fixed 1GHz @ 1.0V OPP we are running in by default at the moment.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



