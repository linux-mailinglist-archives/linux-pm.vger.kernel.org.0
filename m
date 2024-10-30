Return-Path: <linux-pm+bounces-16750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC809B6A30
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 18:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B8AB20E6B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EB7218D69;
	Wed, 30 Oct 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDyx06VO"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3905217456
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307473; cv=none; b=JLefYHSxYeXY1i4pXegfPWC5a0Up5ighlrKk+MynIrsqoGqMP0VlkZQSALOExNXPnx8nE6ZocXC66AERqOkMFT6bFKn0bMqLehVQv0qIyvioVlhpGQdUjVh22RAkYcBrBF1Z4qJZijFDVIx7AV75ana4GUrx3WR7asowTccNCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307473; c=relaxed/simple;
	bh=MUg/AqlACYeJZuyLU/D4ZsuzJ3Jb0wplsvX+Dzj6hS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh4QAjuQcDQQ+toAZSR3V7yy/NJ+ZYI9+fagaqQFtPVutZHrTxC7d59CWojQtasGGtq4TsyXbF0F52OJ+dW0XOFqMYc6uwr3/Ux4J3Xw6VOgYabq5ktVZGQq4aOyc69W7zna8Hp3+W+3slnKPt/NlbdGOqcRq/EogOZXOu5O+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDyx06VO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730307470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQWTrgmGWBGrBXpPJKHJztraJEV3X5HkMcorOSdjP9I=;
	b=jDyx06VOJZGbwKg/wqQVZsnp/0dRv29yQQBdJv6akDEuwn7VfQl3A6XXwb8si6SJ44JbTq
	W2a8kYEOaFlyKN/kvcl4LF4fGCZT1LBln9UrRN41++DFm6jPagfQknLSSJYL3vqVE++Btv
	WQIHEgAW8T7LP0UNd2aUU/PXeTS9F6o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-yIcGVbKuNR2vIHnvvisNWg-1; Wed, 30 Oct 2024 12:57:49 -0400
X-MC-Unique: yIcGVbKuNR2vIHnvvisNWg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cdeeb785c8so915186d6.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 09:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307469; x=1730912269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQWTrgmGWBGrBXpPJKHJztraJEV3X5HkMcorOSdjP9I=;
        b=d1PA4rZFjf/J/QSOHrVMlK5aoxc8wERhcXHYuaDww3hNVZEbdf4JOjN83s+Kdgbv7Q
         tazZzysTze7d4Ot2k25R+VeP9/8LC7zT/xag8hD7EpSWbeB8R8YprNm5zjApJAN8b5bJ
         I3xqN0Sb5AVRGPAznzQA5KMY6+a7uaT+zTHYWJu57ygYL9peDmUQ0BaqPNDe8uuvJf3l
         gXJKS/Ej0Nyu5hK9IHh7RVp7OM9xX5ExQWKURzV5IoP1qbyEcDPtHSwW1g+Ez/ncPjg/
         8PgcLAhkYt8X3xNaZhsJms5t2p5X5DjKVOK/WsBhiZxEGKGCXRPVMeMG4Ey4LJ2bFSrQ
         oGrA==
X-Gm-Message-State: AOJu0Yz5enzCWs28jgKyi4GOObdmYerrbpsqzv/AaiMRETylDzUYWaiH
	mk+2hODeXbOauKrzw7uMLJFu7febXJyqyWL395icZCJ3bTl+hk6SlyUxgnsWfxGd8cGbA49mVW+
	K1ubzPXoHfU2KbNrQPbfXDlXhutHrcdK5XE8PiMAwJxI90usBNvw7IN5QZf8V2P/T
X-Received: by 2002:a05:6214:448e:b0:6cb:99db:bdd5 with SMTP id 6a1803df08f44-6d185853395mr270032406d6.39.1730307468633;
        Wed, 30 Oct 2024 09:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwaNfJfa8CT5a1qeELpBazDzLhRcaRV4TD0jNvOLfsNepdXBrhzyrPoDSK035eKLLGaI2bAQ==
X-Received: by 2002:a05:6214:448e:b0:6cb:99db:bdd5 with SMTP id 6a1803df08f44-6d185853395mr270032236d6.39.1730307468370;
        Wed, 30 Oct 2024 09:57:48 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a0a5ebsm53212266d6.90.2024.10.30.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:57:47 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:57:45 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Vishnu Sanal T <t.v.s10123@gmail.com>
Cc: linux-pm@vger.kernel.org, trenn@suse.com, shuah@kernel.org,
	jkacur@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] implement set_enabled functions on powercap.c
Message-ID: <ZyJliZ3Uka8R5ilh@rhfedora>
References: <20241019124233.194140-2-t.v.s10123@gmail.com>
 <20241030152706.179779-2-t.v.s10123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030152706.179779-2-t.v.s10123@gmail.com>

On Wed, Oct 30, 2024 at 08:57:07PM +0530, Vishnu Sanal T wrote:
> Implement the functions sysfs_set_enabled, powercap_set_enabled,
> and powercap_zone_set_enabled on powercap.c.
> 
> Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
> ---
> Changes in v2:
> 
> - simplify the implementation of sysfs_set_enabled using system()
>   function.

Hello Vishnu,

Ty for sending a patch to implement this.

I got several warnings trying to compile your patch. Please resolve
them. I have not tested your code yet. How are you testing your code?

> ---
>  tools/power/cpupower/lib/powercap.c | 31 +++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 94a0c69e55ef..a2c0c33b7729 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -70,6 +70,17 @@ static int sysfs_get_enabled(char *path, int *mode)
>  	return ret;
>  }
>  
> +static int sysfs_set_enabled(char *path, int mode)
> +{
> +	char command[SYSFS_PATH_MAX + 10];
> +
> +	char yes_no = (char)(mode + '0');

What does yes or no mean for setting a value?

`is_set` or using something with the word 'mode' would be a better
variable name?

> +
> +	sprintf(command, "echo -n %c > %s", yes_no, path);
> +
> +	return system(command);
> +}
> +

In function ‘sysfs_set_enabled’,
    inlined from ‘powercap_set_enabled’ at lib/powercap.c:95:9:
lib/powercap.c:79:9: note: ‘sprintf’ output between 13 and 267 bytes into a destination of size 265
   79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/powercap.c: In function ‘powercap_zone_set_enabled’:
lib/powercap.c:79:40: warning: ‘%s’ directive writing up to 254 bytes into a region of size 253 [-Wformat-overflow=]
   79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
      |                                        ^~
......
  203 |         return sysfs_set_enabled(path, mode);
      |                                  ~~~~   
In function ‘sysfs_set_enabled’,
    inlined from ‘powercap_zone_set_enabled’ at lib/powercap.c:203:9:
lib/powercap.c:79:9: note: ‘sprintf’ output between 13 and 267 bytes into a destination of size 265
   79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>  int powercap_get_enabled(int *mode)
>  {
>  	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> @@ -77,12 +88,11 @@ int powercap_get_enabled(int *mode)
>  	return sysfs_get_enabled(path, mode);
>  }
>  
> -/*
> - * TODO: implement function. Returns dummy 0 for now.
> - */
>  int powercap_set_enabled(int mode)
>  {
> -	return 0;
> +	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> +
> +	return sysfs_set_enabled(path, mode);
>  }

lib/powercap.c: In function ‘powercap_set_enabled’:
lib/powercap.c:79:40: warning: ‘%s’ directive writing up to 254 bytes into a region of size 253 [-Wformat-overflow=]
   79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
      |                                        ^~
......
   95 |         return sysfs_set_enabled(path, mode);

>  
>  /*
> @@ -180,8 +190,17 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
>  
>  int powercap_zone_set_enabled(struct powercap_zone *zone, int mode)
>  {
> -	/* To be done if needed */
> -	return 0;
> +	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
> +
> +	if ((strlen(PATH_TO_POWERCAP) + strlen(zone->sys_name)) +
> +	    strlen("/enabled") + 1 >= SYSFS_PATH_MAX)
> +		return -1;
> +
> +	strcat(path, "/");
> +	strcat(path, zone->sys_name);
> +	strcat(path, "/enabled");
> +
> +	return sysfs_set_enabled(path, mode);
>  }
>  

>  
> -- 
> 2.47.0
> 

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


