Return-Path: <linux-pm+bounces-4473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A6286A0F1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 21:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714AB28C1C4
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D114DFE7;
	Tue, 27 Feb 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bLRbZEz6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3D14A0BE
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066347; cv=none; b=uGN/coZTlYAu45hkP0fgjp7qy0W7dRnh0/x2B44XX/dzh+eWXnxXFbTDME+mY0reo27z5DoKEt2yPtVQ+vjcpt+o489RWj20Xg6EtcTkwo1fLlUALlWZjeBgncLnR8QrPW2P9Qy17lI+tFJQECsf1HP0clmtCxTGMEy04DW0bpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066347; c=relaxed/simple;
	bh=xdH9wQvuibGdS3521b3Yl5pFCguEtjPF9Q1VnrR7fFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vqpnbv3+zLsj/Sko1jveNo5cRF7TcEpQaqUnU9MFJNq+R0TVRKR8421tZB4VpnQNtDZbRcxkENNSASbgpH9OF61YdAdMfXP1IrqrSSDKaLPDglFvnMLehYYBNpgRjoURnGSg63WmaUNZlwTGsSNNKDvHTqyUs73e6ItabMW7kwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bLRbZEz6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e45d0c9676so155516b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 12:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066345; x=1709671145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from
         :dkim-signature:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X59fJ/J27eMKvNmrbhkx6PxMNMDqien6ZCKa8BPpIww=;
        b=qNFrNGSD3gtyWU5XvkPui0RQDVGQezo+gzvVAxbLZbO9D8i5pQqNXFKS2TxzKOhz+6
         IHd9L7GLxvzrR3kNHvrO0qHEMMqnYgxZv+Y0FVXp1P80ks7Q72NTJ2W6cTmjbMVwsNDQ
         8/SFs23TY1LlyWsIPjmvDEwDdv/E5p+Y5x8VhSLO+8JkGAuFzKfGKgfdceHaXnv8nSC5
         ObO9Nx495kVct0NkYODt6GtRKJuupcyIH2pl1v9NrvuXaLlv0uvrBUsoWLPH0LVrwot8
         b3Gc4J/VYLyG3OzuMwb3BOmARYjGCItQGk+5n+5DqB54GxQOa1Zop6vXAROD70EIeBVO
         N99A==
X-Forwarded-Encrypted: i=1; AJvYcCUM3zLhXVBr/8QTEnQHxFA49cSshjRqKiXp8LWX6SeJcJU6SFDhZhXQ15uTfC7BW4r9t46Uv4WOzk2Kjb5yJLcNV2kYB0KAZrU=
X-Gm-Message-State: AOJu0YxQTfZLyMC+NGl4yO6lZSZX6S4NsG5oddnJK/JUei4k58rwZgN9
	zGPJDMZPaW3Ii3auITJ/uT28674AueYeMQePekoJgeXhVRFfy/OXjR+bjy5+cZ6OQg==
X-Google-Smtp-Source: AGHT+IFb6JG7YBhYPZqeAm8ix8wFHy6yu6Mt/bkWiC5vchN3UVxztPKRng0x+W4ZGdC2kfbQIvZmmA==
X-Received: by 2002:a05:6a20:2d11:b0:1a0:f7d0:e680 with SMTP id g17-20020a056a202d1100b001a0f7d0e680mr625884pzl.5.1709066345278;
        Tue, 27 Feb 2024 12:39:05 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id r6-20020a655086000000b005dab535fac2sm5280361pgp.90.2024.02.27.12.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:39:04 -0800 (PST)
Date: Tue, 27 Feb 2024 17:39:55 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709066343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X59fJ/J27eMKvNmrbhkx6PxMNMDqien6ZCKa8BPpIww=;
	b=bLRbZEz6uGE7FJfH+n71Urgd0JxhXeNRZSQruhon2LuAPDpvUb1H9jN1mIeywNQmnUN5qp
	FZEvCOzcDK9q90gVkgil4kBb180OIuiiTD/at90R6TBJFhizjGiY7uryfrWwvztJxtcvv2
	w4JZxnXb/JNA9XQ4lULlhdq9P1Wks0VXDorjZIF5+AmuaPUJHIIMIx0nUwzoZesnuakKtG
	qkE2yP4WnL49GnLNRhjhkD+iJ2sEqUbFUHOtQOJWUuF6mBsjYO6C3rcOlBZoDe4gkenAkC
	mvXMjgWyK0rgF8DudDLbJzRXOOAjyx5gU81e5baZOy2W+AGtBhT7S/OHl6wrnw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Nathan Chancellor <nathan@kernel.org>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] power: supply: core: Fix power_supply_init_attrs() stub
Message-ID: <mlfrfarnnv3i4xwgqd3pavpwxjktkqf2afidoc4ogdq3634jah@kposnyo6725z>
References: <20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org>

Hi Nathan,

On 27 Feb 13:34, Nathan Chancellor wrote:
> When building without CONFIG_SYSFS, there is an error because of a
> recent refactoring that failed to update the stub of
> power_supply_init_attrs():
> 
>   drivers/power/supply/power_supply_core.c: In function 'power_supply_class_init':
>   drivers/power/supply/power_supply_core.c:1630:9: error: too few arguments to function 'power_supply_init_attrs'
>    1630 |         power_supply_init_attrs();
>         |         ^~~~~~~~~~~~~~~~~~~~~~~
>   In file included from drivers/power/supply/power_supply_core.c:25:
>   drivers/power/supply/power_supply.h:25:20: note: declared here
>      25 | static inline void power_supply_init_attrs(struct device_type *dev_type) {}
>         |                    ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Update the stub function to take no parameters like the rest of the
> refactoring, which resolves the build error.
> 
> Fixes: 7b46b60944d7 ("power: supply: core: constify the struct device_type usage")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/power/supply/power_supply.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> ────────────────────────────────────────────────────────────────────────────────
> modified: drivers/power/supply/power_supply.h
> ────────────────────────────────────────────────────────────────────────────────
> @ drivers/power/supply/power_supply.h:25 @ extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env
> 
> #else
> 
> static inline void power_supply_init_attrs(struct device_type *dev_type) {}
> static inline void power_supply_init_attrs(void) {}

I've missed that #else in my building test. Thanks for catching it.

Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>

> #define power_supply_uevent NULL
> 
> #endif /* CONFIG_SYSFS */
> 
> --
> base-commit: 3da8d71754d3c1aa0b72d74c8a324a4bc7fab473
> change-id: 20240227-fix-power_supply_init_attrs-stub-7be5328b4e72
> 
> Best regards,
> - 
> Nathan Chancellor <nathan@kernel.org>
> 

