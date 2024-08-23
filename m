Return-Path: <linux-pm+bounces-12792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C16C395C644
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71661C2230F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080713D24C;
	Fri, 23 Aug 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="x61nUTQ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBD13D24D
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396966; cv=none; b=DhzTRv3pJPfQZort8lD70XdxD8wiwo/TqXb0Tp1MKfAkp9x7lSx96y5JtlnDokWeKk6IpmQn+/AyIYfMtZPdMzC5HDWS1veSovnPXFIrezH8zQpgxbkXH5ANgsR04H/kA6vMCTEV1xaoaBSqHr6NLbsHy6Z1dbomFWK0OFqqsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396966; c=relaxed/simple;
	bh=rOmiKvE4YC4gVq+QxHki/4pKEr+Sh15p2TsZEHY54yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iguKZ7J3+WQDfFQlgl/myyHNmDQLOL6B8wEnSmNFCthDGgmt0zsupL4lQL3v9uLK0lOSubSbZYND+onri1eGyhnAjsM3XG723RFXSFNwrfbVLCgk1CMiL3I/De4oJqRc6gMw1uuP+G7mYlaaoJlkKDV6CAr9N0tS7eJYCw+dqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=x61nUTQ9; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f9339e52cso64753439f.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724396963; x=1725001763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+xtomViJRKkecljBjWQnaYi+v9/a71K9NKTwuwwlJ0=;
        b=x61nUTQ9t2G6SLs5FdOTAMwW4sozEBE5E9xrdWz3S00pU9JnCBAvGqu+1PN11bE1WB
         rONlIPRALP1zbLho7NMUB1IXbm5Amtv2+6HnGkJGbjpGYIardHkXqE0zvLitLJs5thpa
         NJLug5epVx8F4nL+paVnuwdhKkJMFGYHRPVVfqcuhtMosMhc33MphuqslAkd7VBdVlKO
         di2x71160plpopC2u/JgDIHXTJZYZAWaB6EDsaYwbrqiyeyRQNuos8vYID4Z93u6UGYm
         cz7lNReQfS/XJJUDeQ/BEO8/Y/oTdMDF6+Eb369kr4j9pmGpJNAfp8ogvQpbvj0UzC3v
         0N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396963; x=1725001763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+xtomViJRKkecljBjWQnaYi+v9/a71K9NKTwuwwlJ0=;
        b=W7i5VLfF3D5idi1K/6kj4aKjsGSME8Tb1R+fiTlHsZeqQiHA8t+vdBx+jGzuCPYRGL
         sjXgQSExzjEOxdlJgt2fvsRVeR84i4aASTkBJpzavotpgURcCXd6nmHLPhVOeJebOzlz
         xAFPiPsgP3m78a52v2B6R5hwcXckJ+5YaBuK2o+OM9E0OkBOZjkqg5dB6YiD8M36nI9m
         WyeXXhavON3ugyspEXBm40BMG2k4SpOBqILR3+yGbcTVIsCdLPJgwtt7U5MpI0Y2X0+0
         ihemV80teeLoy1PVwN0lh/Yg0OoEUwvpNc0Pyz6Ss234P7pmkCU3arbVjE7al07M/U0s
         8J6A==
X-Forwarded-Encrypted: i=1; AJvYcCXgt3ra/otATkQitKQ+PilqBqJ4H/2tI57W/Zzaf4mIf5bWCwR+OPogJJG4ivcJ/Kr0w90KjkWQAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFKUH6kPDL9AAYvSGWLC/VhkOmpetTM5UvO0gLKdyA+ba+nMIb
	w3EM1f6lSH28TdhW37IZuomwI9gw4OXV3g6NxMmRpazCJEWJHu+WQ3kOq/F69Z6P5EmWsn1g7GN
	ss4Bt1H+2jwS1OzYUyqwAcgRhAzWx+uB1BL2n6aIOp/b7r3G/
X-Google-Smtp-Source: AGHT+IFvCf4E3AaZh8GOYF6qDZtM9rSpNnAk22CeUU8eVSdJtW5sQOCjzvPdcdppk0FFBC/EkZxVm+WiWqVpIISR9II=
X-Received: by 2002:a05:6602:14cd:b0:7fa:56f0:ad87 with SMTP id
 ca18e2360f4ac-8278732f754mr186317239f.10.1724396963618; Fri, 23 Aug 2024
 00:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814054434.3563453-1-nick.hu@sifive.com> <20240814054434.3563453-2-nick.hu@sifive.com>
In-Reply-To: <20240814054434.3563453-2-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Aug 2024 12:39:12 +0530
Message-ID: <CAAhSdy2HkZrd6VmZ=L84soCJ0gcix2J+6MOMZ15OT8ri0=m1xQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
To: Nick Hu <nick.hu@sifive.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	greentime.hu@sifive.com, zong.li@sifive.com, 
	Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:14=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> Move the sbi_cpuidle_init to the arch_initcall to prevent the consumer
> devices from being deferred.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Link: https://lore.kernel.org/lkml/CAKddAkAOUJSnM=3DPx-YO=3DU6pis_7mODHZb=
mYqcgEzXikriqYvXQ@mail.gmail.com/
> Suggested-by: Anup Patel <apatel@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index a6e123dfe394..98e7751dbfe8 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -592,4 +592,4 @@ static int __init sbi_cpuidle_init(void)
>
>         return 0;
>  }
> -device_initcall(sbi_cpuidle_init);
> +arch_initcall(sbi_cpuidle_init);
> --
> 2.34.1
>

