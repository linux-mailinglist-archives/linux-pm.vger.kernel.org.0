Return-Path: <linux-pm+bounces-41657-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePkpCj2keml48wEAu9opvQ
	(envelope-from <linux-pm+bounces-41657-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 01:05:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83586AA162
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 01:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4D5300AB1A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C35749C;
	Thu, 29 Jan 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZJryBXe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A14A01
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645113; cv=none; b=AR6Y3+iIL6NqqoOrq/s5TJE/cVfgYksHty7PKYYsoXsvaeHEZiqnCaI+6qgq+Nu1ESV0OxRH1hv0HHLjNlgZvSbug+6r2A48XPQSJp8gkcAl1XvsfCmTIUa5WCmDWWrjx/RqOswlWsUN4IvYVvC8aNLDdIeWveAEJCPhAtwavY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645113; c=relaxed/simple;
	bh=6bTQq4AnwmBJiKQMZZrP7B4Z8nl1QlAInj4c5tQgTP0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LuncdlWoQGi+PAM4vXVSB05u97gOOAZCaFcybp3X2xcsdEnkEgY3fAeA4bxDZf05jHGPHEZHRZONkOwWEISgawlQVr771ebveY1OD8E2zQr0nATsXsI5QjsDQ2MSbwG7SqKpM9VyLoXXJJXrJ4YhSttyUjWiftarSZamIy6eGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZJryBXe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48068127f00so3037645e9.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769645110; x=1770249910; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO9q1FqPVyJS0YVVCVQa38cDaBaynSuUs+m6INxISao=;
        b=NZJryBXe82QkfHqnANn7URdVx3cyyNKqD1pdJOSUirKLSu7ChHcWZQJkuWoPLyISVW
         XLYReKhq9k+vo7yBXiALoWDaXf5E54E2DoV/SgEeOMy2z85OLFb3Q5xn/nplNjkpC+oo
         fXTtLi/pCsDwSOS4qe5gUr57HMPPb4tNziVjOzaxBE5rVfOU94tGNIuv8FVZQnxrz/BG
         loAN8+DWHo6fpBbJTsOYJeQAzyttSIXVUuoAlQ+UeIUwbPXabzuCMd7hpI3uWVCST0yn
         Aw6gcRde9p6vA5qWlYnCZHpsWNKrL141E8bnCij1LIi0HELVeCSJZHvMULUn5SFvNUfs
         2XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769645110; x=1770249910;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eO9q1FqPVyJS0YVVCVQa38cDaBaynSuUs+m6INxISao=;
        b=S47ntFdPpXCyAvFntD99M5PGm2CHuZ9UkQ3pe/IzZx6/vfmktpO1GA/bsXR8mru5O9
         NiLbQU/5cl7VmIurAIAsQXRq3S3FfSCP+FPcDxxxDy61LIna15dlAkzO9+RlF5/sz1+T
         Z0kNBDAtyEKidW62YnzDDvNslEvddS2Ge+7oZtwXozZ5hIxarw3+5ZWkAf9k7QMHI1yc
         mUZF0G9+NMbr1icXXm0Ai1LeUU77T7AtR8GuVSA8cSOZTpKRtV3WznJ49VWijbxuu+Xs
         eVft+DeyUxSinqTtZw1NHs8Bg/xOYBPlk7KKB6FUG914bHxqbg086cNg44nVnsXB8tfs
         15ow==
X-Forwarded-Encrypted: i=1; AJvYcCWLY6zOLhEmW+SpSbLM9yIXjXz0ADbVKm0FNRBzt84pYbxQv3AI7XwNFMZ0tcl2aLoSzTx3i7WA8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJ/A6iWiT3AloYhEdSbEremJvx5TGqPAsII6MIJdq2aEH3qjY
	plDZAvdzsnFi67gZ4e31K+Gv3MYPD7oDk1BldKbmtM7mPeECcl5hq1GBl7s49yCLmtI=
X-Gm-Gg: AZuq6aKs9AQAaUQma3WPPhWmXykgEmrGrlX9WryubZpYa6oJsOgN6EcLnZgslJkSWD4
	hZhpP8n0/EQYSfcJw9WgmAiMzRreq8objya/GQualMSzbGY6T3gmPADhqQrblG+yKo6WoFksRAF
	NirBhGBnZn7C2ghR3nHG5eCkTeydxIduI01t9M3KUCDHj/oQIGhT4OmMtsTJfpbxbLFyQk2Nedo
	aBgGMAcaeT+TykXWELVYDFAP60TU67POElNI8i6LYV6vBcazR9cbyEDJjQ47AFUP6ySIlI7jF6B
	pSOymo9i7k037j1h2ysK+K8+YIsdM1NEMW3bVVYObbKh1Ud2riBz/MhiHIhwarVpSvVsIqa0NMU
	vYZIorqu3J6+APh+qXAI59LvcIt4DjVxaNsbvHQVRVxXpy307xb6NMz9wFYjUm3xYYpausJbXeV
	YDgsSvtlT+vc8/jbM0N0zSpfUvZYJDgIF7pZxnqsOOn79fynRrBuM0t3Ak7Kj78uViiA==
X-Received: by 2002:a05:600c:1992:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-48069c789e8mr87706365e9.30.1769645110421;
        Wed, 28 Jan 2026 16:05:10 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a3bc:1b62:e67c:4ac9? ([2a05:6e02:1041:c10:a3bc:1b62:e67c:4ac9])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-481a5df6fd8sm1740765e9.14.2026.01.28.16.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 16:05:09 -0800 (PST)
Message-ID: <2ebd51a4-4b69-4179-9e23-ec1c38fdc803@linaro.org>
Date: Thu, 29 Jan 2026 01:05:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukasz Luba <Lukasz.Luba@arm.com>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Laura Nao <laura.nao@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers update for v7.0/v6.20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FREEMAIL_CC(0.00)[arm.com,vger.kernel.org,bootlin.com,collabora.com,public-files.de,linux.intel.com,linux.dev,renesas.com];
	TAGGED_FROM(0.00)[bounces-41657-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@linaro.org,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[twitter.com];
	TAGGED_RCPT(0.00)[linux-pm];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 83586AA162
X-Rspamd-Action: no action

Hi Rafael,

please consider the following changes since commit 
9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

   Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.0

for you to fetch changes up to 0061030929e2d09398ade9fae320528bdcba2bed:

   thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H 
(2026-01-21 19:06:57 +0100)

----------------------------------------------------------------
- Fix CFLAGS and LDFLAGS in the pkg-config template fir the libthermal
   (Romain Gantois)

- Support multiple temp to raw conversion functions for the Mediatek
   LVTS thermal driver and add the MT8196 and MT6991 support (Laura
   Nao)

- Add support for the Mediatek LVTS driver for MT7987 (Frank
   Wunderlich)

- Use the existing HZ_PER_MHZ macro on STM32 (Andy Shevchenko)

- Use the existing clamp() macro in BCM2835 (Thorsten Blum)

- Make the reset line optional in order to support new Renesas Soc
   where it is not available. Add the RZ/T2H and RZ/N2H suppport
   (Cosmin Tanislav)

----------------------------------------------------------------
Andy Shevchenko (1):
       thermal/drivers/stm32: Use predefined HZ_PER_MHZ instead of a 
custom one

Cosmin Tanislav (5):
       thermal: renesas: rzg3e: make reset optional
       thermal: renesas: rzg3e: make min and max temperature per-chip
       thermal: renesas: rzg3e: make calibration value retrieval per-chip
       dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
       thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H

Frank Wunderlich (2):
       dt-bindings: thermal: mediatek: Add LVTS thermal controller 
definition for MT7987
       thermal/drivers/mediatek/lvts_thermal: Add mt7987 support

Laura Nao (8):
       dt-bindings: thermal: mediatek: Add LVTS thermal controller 
support for MT8196
       thermal/drivers/mediatek/lvts: Make number of calibration offsets 
configurable
       thermal/drivers/mediatek/lvts: Add platform ops to support 
alternative conversion logic
       thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
       thermal/drivers/mediatek/lvts: Add support for ATP mode
       thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit 
calibration data
       thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
       dt-bindings: nvmem: mediatek: efuse: Add support for MT8196

Ovidiu Panait (1):
       dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU

Romain Gantois (1):
       tools: lib: thermal: Correct CFLAGS and LDFLAGS in pkg-config 
template

Thorsten Blum (1):
       thermal/drivers/broadcom: Use clamp to simplify 
bcm2835_thermal_temp2adc

  .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |   1 +
  .../bindings/thermal/mediatek,lvts-thermal.yaml    |   3 +
  .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |  34 +-
  drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
  drivers/thermal/mediatek/lvts_thermal.c            | 362 
+++++++++++++++++++--
  drivers/thermal/renesas/rzg3e_thermal.c            | 123 ++++---
  drivers/thermal/st/stm_thermal.c                   |   4 +-
  .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  29 ++
  tools/lib/thermal/libthermal.pc.template           |   4 +-
  9 files changed, 483 insertions(+), 85 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


