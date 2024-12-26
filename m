Return-Path: <linux-pm+bounces-19771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6339FCDCF
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 22:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E807E18833C1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004A18A6CF;
	Thu, 26 Dec 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsOPAEjO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC242AA1;
	Thu, 26 Dec 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735247781; cv=none; b=iPn7+oOXxSuMc9eJymj9xbze9H/qtqW/Besd4IG++J8+zbqIQH5mv+ekqz/O27QuBYBHDf6yuNbU9KkbK5MhOERoFXwoFGDMUAGiAbIscCc3GlvbLNcWlIjLVJfe2Rvc0/lXvOMR91AVjsPs6tyEDkz25ozCUwrrgi+yr4vPf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735247781; c=relaxed/simple;
	bh=so7iA1i5t/DOnU+rwMvXBwjMF37JzkMnKJEO6q7i6tE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qVNTkLTIaYQDJEvfmX5+zFWiZc/L/MTJVjPmIM2xcH5JYyqBrQzbG+blmtp/any4a64+gkVPDnGtp0SEj+xVS7xP+sG5T0OS2LfWn+GtikCbbc20Vv+hAw1wbjaxU7LvAeBKzl+9eFcLzyebVhRP149WGrjoDoMBuW1D+zj2f/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsOPAEjO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so42837675ad.0;
        Thu, 26 Dec 2024 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735247779; x=1735852579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=so7iA1i5t/DOnU+rwMvXBwjMF37JzkMnKJEO6q7i6tE=;
        b=hsOPAEjO90liV7p+jfR3x0C4V9my+mB4U696mBctMUzVeFuS5gg68eeoWWMa2YWavk
         P/AtJip+TWf2PaA9Opz5v0FDPtr/52FWGnej2sXHPQgBRuGpg2clUxU0Wz9pILJ2KhUl
         jiP8t/OBjUF+FF06vi48a3mtXcZNs14N43W0ChCF64xnt7fon/IIMpY/OImia2KM0zXY
         +OJKFoTArggdR8L09dBTz9bCJ5iuTcLA3xcymZI+oJtGZAIvVaGg018v9ySKSaVwbz2r
         FdKXVWw8PnSxCNYTHdGJIteanODjGCq5UjEJP2p4X4FLuroJ9rNPLGBk3EZU3P1BG4O1
         VmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735247779; x=1735852579;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so7iA1i5t/DOnU+rwMvXBwjMF37JzkMnKJEO6q7i6tE=;
        b=EBjufgHr1PULyivZNtBHRplTbdOd/ewwgk44kmopHTsSNXq5eBitStlz4YqCaNavBd
         W3OQCEMhhSFYXiBq913nGiSjLFeVP7Oz2aruRqPoFvl5jh782cpAvvBTl7KGk2jBhtB0
         DvJTwTJkouXZ79sEdMvOSjdT3xRtxCJaOEWM0xN9lBJKxgPUls1f8WIfIz9qFK6fJK4r
         OVYOEzRLpBoq+atGVBt97vEFc6F2l5tDSggte1uz4JS9lhtPOwxsL6dleoGLV+gKxWJG
         6shRDH0fBiZjtSTbT2D7JXROIHDLZB9iJn6y254Dh5gMUeNJ4gDxfMCeYMTeRD1+EmmO
         c5jg==
X-Forwarded-Encrypted: i=1; AJvYcCVL4daMm/qgri92/cfQ//MVQpOO1gk4m0tparCP6w7kj4SUvysSHXskHnSNIpG0OP08r7V9urBe0/g=@vger.kernel.org, AJvYcCVmur/TapikCpondsv8cnEsxjSEd2Tc2j3hOAVdHqVcAKviO8SpE8+RaKsSgUUxndrCc3Nh1al2o1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwsXOgYvUoJOMDnOCFqOSzpsLOmq3J6UdifvNjg03vSPSQx7M
	QJgf3Mr3TSpw2z4apcvzTWqPqaKPUop7idHjkZnsjz/6pWnOSnmw
X-Gm-Gg: ASbGncvZc8+NYgb+fYIlh5D2zun2jACM2RDB+5B0ECwR6IU+lKj8JYhaMRagfykYYqC
	P8aLPLo1CrQY0+Cf93Xli7qp5KB95sjo2tY9J5SGNLrZah+HjRwtW4xbuunswXd2Dkvn/qviavr
	ILVhnWhn8t5wclXjNpV2EIwMKWM6L3DbvKYYIhaEDNHAOHkqwKL3XuwHyQrvfp6+HFgP2R5e8Xz
	bTjbhJy1XI7NmSiUXnXdo65Ng7yZ4QbeIm4nayPgO3j8tuZZJFOENefNyEhvg==
X-Google-Smtp-Source: AGHT+IHpTbZGshERS1cvbLiy3MSN1OK8iY5Xj7a82lhsjqbqrzDkY2wkJWlh5sRwbck0+6V9STquJg==
X-Received: by 2002:a05:6a00:124a:b0:725:f4c6:6b68 with SMTP id d2e1a72fcca58-72abde404e9mr34148228b3a.4.1735247778612;
        Thu, 26 Dec 2024 13:16:18 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb91:160:4100:ad2:fe52:5206:995])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad831160sm13313062b3a.59.2024.12.26.13.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 13:16:18 -0800 (PST)
Date: Thu, 26 Dec 2024 13:16:15 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Antheas Kapenekakis <lkml@antheas.dev>
CC: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_00/10=5D_hwmon=3A_=28o?=
 =?US-ASCII?Q?xpsensors=29_Add_2024_OneXPla?=
 =?US-ASCII?Q?yer_line-up=2C_add_charge_limiting_and_turbo_LED=2C_fix_ABI?=
User-Agent: Thunderbird for Android
In-Reply-To: <a8e6d5d5-703c-47df-ab57-58234fdeefc1@roeck-us.net>
References: <20241226112740.340804-1-lkml@antheas.dev> <a8e6d5d5-703c-47df-ab57-58234fdeefc1@roeck-us.net>
Message-ID: <E24291F9-731F-4C27-96C7-BD08FBCF7A76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 26, 2024 1:08:02 PM PST, Guenter Roeck <linux@roeck-us=2Enet> =
wrote:
>On Thu, Dec 26, 2024 at 12:27:30PM +0100, Antheas Kapenekakis wrote:
>> This three part series updates the oxpsensors module to bring it in lin=
e
>> with its Windows OneXPlayer counterpart=2E First, it adds support for a=
ll
>> 2024 OneXPlayer handhelds and their special variants=2E
>>=20
>> Then, it adds the new charge limiting and bypass features that were fir=
st
>> introduced in the X1 and retrofit to older OneXFly variants and for
>> controlling the turbo led found in the X1 models=2E For Bypass, it adds=
 a new
>> bypass variant BypassS0 that is only active while the device is in the =
S0
>> state=2E
>>=20
>
>This is a hardware monitoring driver=2E It is not a charge controller dri=
ver,
>and it is not a LED controller driver=2E If such control is wanted/needed=
 for
>this system, it should be implemented either as mfd device with client dr=
ivers,
>or the entire driver should be moved to platform drivers if there is a de=
sire
>to keep it as single driver=2E
>
>Guenter

I think moving this to x86 platform makes a lot of sense to ensure two sep=
arate drivers can't do async writes to the EC=2E We probably should have do=
ne that when adding the turbo button toggle anyway=2E I'll coordinate that =
effort with Tobias and Antheas directly before moving forward=2E

Thanks Guenter,
- Derek

