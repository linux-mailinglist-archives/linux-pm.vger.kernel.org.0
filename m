Return-Path: <linux-pm+bounces-18381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59989E0D4E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689A1282580
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916D31DEFE5;
	Mon,  2 Dec 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl5Mep/D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D301DE892;
	Mon,  2 Dec 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172486; cv=none; b=eAxV0Fh9VG8MRdzjoFOiWxa9blft5foIz+IcTs9lPOV3gHLnDsQaeNaP+7We8bI6K8qX2UtRTnPr3Y+H0T3qhNv5oX3AIIBTN33bOKZdoWEVGHuJo4PmzSwCS//tQPllGCgBiA5HJxwJXYS2MBcbhfTF5vbxAVOkFPsm4i6BLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172486; c=relaxed/simple;
	bh=FIkHDGIOXriB54W0ubRvHPv/UhZwlrA2MtLA5Q77FLE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFofgRjCtFiryUENIiowXRbJvqLjVDJNFBSGDb0rQPnDRrI3E7cVjPd49yvOK9kQbHL/9odzQ61wsFjK/MaTosscGPV3ynTeKgJjwzijAqw5/3mtxR5tE9TqKLy7SuuuZmnxoIMKJgGKFVBAtRVBzAV0FxQog0MtL7oTg9zX1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl5Mep/D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so38575865e9.2;
        Mon, 02 Dec 2024 12:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733172483; x=1733777283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjVnIirWBrw82KSGoTepSxVKXt5nKfWsdxBxLVQCrdU=;
        b=Zl5Mep/DHMo3w0+W2DJ1ZppwXy8LtTCL8eAeenEv/PhPhygR6lcIv9D/YJ/OkUmUfz
         p3VEQ6JUCJdlulIyHV5/+J7+QtILicMAgDi8MQfyZkHQf0uZTqxzXvag7b4K+z3hVI5H
         NRVV1aCUVy8rIYy/ggdFtTcSm+Ef9CbUMC2tW9OwFT4l6k/Dc3mshvKFhUKaqfxFph4m
         /MwAq+fTuiWXy42W0qSMP0YG+qhOceLk0ZEfyYlvW2nM+Y7fbTz5MWt/qwu4U+7ugBl7
         w6CXaOnai+9W7O8c9rRPY7DLq0PGo212QM2l+5w2eNwFbx8teQ8avXfqej9MEmMrt859
         upog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172483; x=1733777283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjVnIirWBrw82KSGoTepSxVKXt5nKfWsdxBxLVQCrdU=;
        b=RlG6XyOuy57zij6XvLneUkIiZDSa/vuplZvQ0TiX2NUlpwJWOnAEfxP69glAcSrsRT
         pMBxesQW0d7Qtpj0LVnLA9erPxZOssvZ5HcbsTWe6jmp3uIr1fihk2We98rM2fkrAnBZ
         0/LKzly0xsJzrG3nifmNQ7DuElAJSMFOguMn1WyJqOtiacSBmZAxbETzqiiBPCy/LN5a
         D5ilNTYbAu2wtrx3kgZL4MI99xCZBa6b94tWC2lTaj3UZrLp686lchczfi2Ymkbgy4Xy
         70uSjUEulW3kG1YKcNe0qCrR8ov69zuAmOABBCT1Bt0ZyLP77QGXWbL8VihGjtVbE1bM
         7uuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZrdknH+8oU85NIDCCxB+iHDTDKwlIUPmoeK9db6OxPknrksLywWGsJIwEkLQzD/twgOLdrDcdswEu@vger.kernel.org, AJvYcCW3jXzkd9NNu8KqV2V36qfS5ftMGQB0qU5oPeHXD0MXiZqVOQneGTCQxhdixN9B8gmQOcVmmALF1vU=@vger.kernel.org, AJvYcCWP6iKtweQj4+o11ct60yh57xg2psDjealhg69fYbVTHIs64t45n0AI0vQJFCAPw1GgVvEzdTZIlNRQDUA0@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEGWhzcZPDKddWrWw1UerxupeLWDmCZPedYSDRM8JwtS7ruZY
	9f3VHggFErkVIxhVVtVyZ2dAqBtcYYd3wzuEPxhu5n+eObO3FAZ1
X-Gm-Gg: ASbGncuaCNEScttWSYl2/zB6JN4L0X3jaNNtTqN80b/woHJDvYAgtJTnNkDCNstUZrU
	gxDNvOxwefTQJHR3ZPWz/7d1mPaEfmPVRT7M+hDaAs/5xeXEVCpMBR2c48P1LjjCrO816Jncoao
	eyjhJBcTujp2rxqrzmLxRFuOitAUdhfnJviTbp7wQ5hTRmrzlxNp9HH7FcqGshxtjOb4B63h8UA
	UAqsMCZak4uT1g1XGKvwcDNGU8zSJOYXMUwnH5S6fNGpMxwFE9x4Mk9vMLXiACxCCyBK+SG2r9d
	rwz7Kg==
X-Google-Smtp-Source: AGHT+IFL5GpxYSf7Ht6CK1swa3FXRHqmwmEsoDZeWj86jAvi4//3AIbVbWtE4B9lfJqo4KeKp0J1zw==
X-Received: by 2002:a05:600c:5101:b0:434:9dfe:20e6 with SMTP id 5b1f17b1804b1-434a9df71c6mr198593535e9.23.1733172483032;
        Mon, 02 Dec 2024 12:48:03 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc9707sm167374135e9.25.2024.12.02.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:48:02 -0800 (PST)
Message-ID: <674e1d02.050a0220.8873f.0e43@mx.google.com>
X-Google-Original-Message-ID: <Z04c_oWdFcPFx1CL@Ansuel-XPS.>
Date: Mon, 2 Dec 2024 21:47:58 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v4 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <20241202151228.32609-2-ansuelsmth@gmail.com>
 <ktzz2btcxjlt7l36k7pgv4widhw45p44ol4hr2kjrf6ui62fjk@2yfvkmvdyk73>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ktzz2btcxjlt7l36k7pgv4widhw45p44ol4hr2kjrf6ui62fjk@2yfvkmvdyk73>

On Mon, Dec 02, 2024 at 09:38:10PM +0100, Uwe Kleine-König wrote:
> hello,
> 
> On Mon, Dec 02, 2024 at 04:12:04PM +0100, Christian Marangi wrote:
> > +static struct platform_driver airoha_cpufreq_driver = {
> > +	.probe = airoha_cpufreq_probe,
> > +	.remove_new = airoha_cpufreq_remove,
> 
> That doesn't build on top of mainline since commit e70140ba0d2b ("Get rid of 'remove_new' relic from platform driver struct")
> 
> Please use .remove.
>

Hi Uwe,
I rebased this on top of next and still compiled but yes sorry it's a
leftover from testing this also on my OpenWrt buildroot. (seems the
commit still needs to be merged)

Maybe you can point me what branch/repository I should target?

Did you notice other problem with the changes? I notice the PD
implementation changed recently.

-- 
	Ansuel

