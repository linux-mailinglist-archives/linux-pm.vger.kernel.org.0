Return-Path: <linux-pm+bounces-19822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08329FDE8B
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5349E161843
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D2813A3EC;
	Sun, 29 Dec 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN1sTtuX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3384D2B;
	Sun, 29 Dec 2024 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735467243; cv=none; b=ZyjC4iV3M5sBz/C/CcRo5QjXmdguyH0ymyybNNNmVgKPrNcBc36ibJ7YfmrpHYM3nU9wm4+KGt+j8HH2nRvBmYbQQi7mVbesRmsNWi+9VJ0B1dhA7mjYbykNDwOuRwdEEQQ0Pg/Gj/uapLPv7AOrtyXfIT4H7FyhvFwaqB1HeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735467243; c=relaxed/simple;
	bh=L62/UD0qN1e6WzDHAYSA2XpLICZ8jE2SBa+RYQ/cpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5DUsvIfHO2gr+ehEnoIe2bP/b0KbExA1B0hUFH/JrU/g7+mb41LtP6nT6lXSDhbCsMUOK/GbGbQgptZVgSg1zK3/lpg2vfJeyssoJafSfpliIeMxyHcdu/o0GWatG3ttUoORXwIMYZVYOBw4oOw15RnQdfs5dOGRimBj5NLubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN1sTtuX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166651f752so120936935ad.3;
        Sun, 29 Dec 2024 02:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735467241; x=1736072041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8Di6vc0ib37rqGtbW5/V5Zy8weI4RXW+W3zwc1p9Tg=;
        b=hN1sTtuXgmgWHGfb1c0kJfk6QQWagC3KESPsRl2T1o3sgPxSHRbFvkfpwX9W2GeaWs
         bmfvJ4dt3QoBy2HNMfJR1yqrw3M5Bajve6Y7n2uMkpa57LEl+OBKwOuMEaWJEUAZh1c4
         jXJZwe/z9vzPZ6aDuk2OuQVKERSFR2g0v6+jNUDrhG8N7s+SY8NnV7z2tX49H08JIAN0
         zciSeQFLs7eFkfyYU1x8NzYoMhON5gYRxPP2RUy/gAVJuQmZfGaqkPMqdPowKRNvwNii
         aHRnFEBGAk4WxNeZllTM37Tl2qihfnyh/uYe6rzdk9ZJEBEK70lN8c7p/ZEp50CaIIjb
         LTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735467241; x=1736072041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8Di6vc0ib37rqGtbW5/V5Zy8weI4RXW+W3zwc1p9Tg=;
        b=D6nXGurnPlKfksfhDIBwfquIw0WYtCcW9SbedP1aB4/98QgyqtLQGBrE43xMAJvlpB
         7oJTtjGPJ7/PF0BaKsohS04766nzh73CyqmAHz6tpWDyVs+W/Bxd5O/awyUcGaSeQJOL
         zt/C10R/vGIvwR1lRTpPd8W++p0i6bhku0vmF3OnGvmDhk3Fe5vC8vA5YQZBDsVc8GAM
         jC4ZXWmj5mBdoqKh6oxj58ka1S7H2TfQusw6vXlWCWBtVjexbuUbWP6mL24N/eMrsQ9h
         hX9Vz+vSHfBuQlTGZEHSRKDJI2atoQEgYVkqCsdoTAS56dcUsW5Bs7szBGPmRA2jhbxS
         X8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUx+E7QBQtHFB8Ejjs7LO8wgyMUov9f/Fkor1YWnQ/6dtp6WR/X3rCl+Zlp3Ha2mX91uUe9eMJwC+sZ@vger.kernel.org, AJvYcCW+kgyhBSJUY4ug+DStNUvXf/99czXsF2nXFp3q4rGXCe/Q5Idh7llR/U0PJZT65HWEjPSpX09xBEAEl/zU@vger.kernel.org, AJvYcCWDAJA0JOvk3/TmxVRevx5k7BmIyKvrs+R5jbt03SN0fcM17wK2Fd2x8D2QaEmWxcCSiB9z9Cy9oL8z@vger.kernel.org, AJvYcCWyg0VOk5qlczAke20lnEGEaFGEjD3npF7wacKUpUBPR3QXEPUCk8SVk+MY3h+W6Q9PczTGAmL1J/dj8Acc/w==@vger.kernel.org, AJvYcCXA1pFSuxfTxotvcb/w9Bf6cm4qtd2ErvFEY37BIpXSNDJSPZEmW7zGRsIEZMOAwN3DdKmonfYaKw4VX6mm8OBOg4WsuQ==@vger.kernel.org, AJvYcCXV6Zx4zINaqrKFxB4FHKLPaN4NgoZIpsz3cT9o9/092InUEWuIV0MlTQoUFFoFdzXJ4EKfN2VGYYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJYA5xYUCxonr3MqCyZLel59PhubczDWVtgY9MYEteG4u9Bm9
	eDF+FI+fRtLzjkPYyEP5h5GF8cTU9vcZR8CKF6zcXUIJtWUe09yu
X-Gm-Gg: ASbGncseqNIYZcvfkeeECAPXcX0d98DtL45sbajbyBK3P6hp93qc5+POK9bP8hChGvw
	CwpYgDmMLQNzoFDKp8ejVBDGeVnW+casU7wa44DOQ8ODqTTdE9IqewOrBsWmvo2SiYwL2u9+HM4
	6nkE4iUXvXp8c3YKjifTNUZ/k82YzpjWtgy5CjzEosmlL78NkUhU7q1FRuWF+hM9BmXF8Km4K4j
	q86DXDs4jz0AvBUhVuRC1yhDf67VICXge9HvVpDtWY=
X-Google-Smtp-Source: AGHT+IGrx7o7ZOkMm9VU035+Ze2w0NfiQTvpW13JQizEctZxoMXoHO6R7sgkk6nmWk2te+DsgsidVw==
X-Received: by 2002:a17:902:f607:b0:216:7cd8:e964 with SMTP id d9443c01a7336-219e6ea1b79mr528479285ad.22.1735467240871;
        Sun, 29 Dec 2024 02:14:00 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4474sm161769565ad.142.2024.12.29.02.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 02:14:00 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: krzk@kernel.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Sun, 29 Dec 2024 18:12:44 +0800
Message-ID: <20241229101244.59779-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <ff53d7f7-0103-4e52-ac0a-c05bf4521cd1@kernel.org>
References: <ff53d7f7-0103-4e52-ac0a-c05bf4521cd1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 29, 2024 at 5:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 28/12/2024 11:50, Pengyu Luo wrote:
> > On Sat, Dec 28, 2024 at 5:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On 27/12/2024 18:13, Pengyu Luo wrote:
> >>> +
> >>> +description:
> >>> +  Different from other Qualcomm Snapdragon sc8180x sc8280xp based machines,
> >>> +  the Huawei Matebook E Go tablets use embedded controllers while others
> >>> +  use something called pmic glink which handles battery, UCSI, USB Type-C DP
> >>> +  alt mode. Huawei one handles even more, like charging thresholds, FN lock,
> >>> +  lid status, HPD events for the USB Type-C DP alt mode, etc.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - huawei,sc8180x-gaokun-ec
> >>> +          - huawei,sc8280xp-gaokun-ec
> >>
> >> sc8180x and sc8280xp are not products of Huawei, so you cannot combine
> >> them. Use compatibles matching exactly your device, because I doubt any
> >> of us has actual schematics or datasheet of that device.
> >>
> >>> +      - const: huawei,gaokun-ec
> >>
> >> How did you get the name?
> >>
> >
> > From website of Huawei([1]), please search for 'gaokun' here, we can know
>
> Then please explain this in commit msg or bindings description (what is
> gaokun).
>

I will add it in v2.

> > this series is called gaokun. Many files from windows indicate more,
> > someone fetch drivers from microsoft server([2]), in one of driver archive
> > 'OemXAudioExt_HWVE.cab', there are two files, "algorithm_GaoKunGen2.xml"
> > "algorithm_GaoKunGen3.xml". And `Gaokun Gen3` print can be found on
> > motherboard(someone have the motherboard, I can ask for it later).
> >
> > So can I use?
> > - enum:
> >       - huawei,gaokun-gen2
> >       - huawei,gaokun-gen3
>
> The internal name?
>
> >
> > Some backgroud:
> > There are 3 variants, Huawei released first 2 at the same time.
> > Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> > Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
> > Huawei Matebook E Go 2023(sc8280xp@2.69GHz).
>
> Well, I believe it is still not good choice because we have absolutely
> zero insights what is actually there, what else is called gaokun etc.
> Especially "gen2" and "gen3" - how can anyone, outside of Huawei, figure
> out which is gen3?
>
> Why do people try to decode some vendor naming scheme instead of using
> well recognized, public and available naming: the device name?
>

Check the motherboard, https://postimg.cc/V5r4KCgx (Credit to Tianyu Gao <gty0622@gmail.com>)
Gen3 must be sc8280xp based variants. There are many clues showing that
sc8180x based variant is Gen2. I don't want to decode anything, but as you
also review Documentation/devicetree/bindings/arm/qcom.yaml, most of them
are suggest to use a codename, the retailer name is so long and confused.


Best wishes,
Pengyu

