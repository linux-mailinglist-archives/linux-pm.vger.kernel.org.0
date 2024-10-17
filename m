Return-Path: <linux-pm+bounces-15885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BEA9A27E8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFBF1C20A19
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8341D417C;
	Thu, 17 Oct 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7/586hG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B617ADF0
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181074; cv=none; b=lyKvlIgSjxYSd4xI1wqWWgF839+29fRB9oPU0C7SG+1sAEgiE17BBV4eTfOi3j9Qj3+FjkE7UeBsTIxZLgxpjYJjaof32WBsPEX8ypC4D/K1g0vkWaa8cMjDWOBM2m6RV8laU01i7s78iaV5Um+hje9FZf/995KxE1KNK4/yVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181074; c=relaxed/simple;
	bh=Nh+K209FOYxiR6nvbGIUFanQpljyDYYu3FWKfknECbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tD6w2gyxZ58CkKeHZ41ciLEdkkyCukZa7JTXPunFHDURO6gwtjrxiEeNJPlqUHjZsQMp9a7H1O1f5VziRoBFBYMb+ue28Y78F/TFLHB9Rk7d/v9tCnBCHU8KT7GLx5/tu/4ixtRxC9c9S95RzEipoD/Kq4h5ftFlEiuUqy+uwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7/586hG; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b7442db5so4075605ab.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729181071; x=1729785871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HcKzCWxvWAVqUtCS9GFF6dDhjA+3HfqRto0OwBOEug=;
        b=S7/586hGciCbY2l3unZ7+QB9Jl/SuFrdKycWwIqn+yO3QjLNZweh0Q8ebDMRY7fSVE
         XZ+OvZ4I2LigDZeH7IOXn/1RzzgKxtDY2442qCmL4/e/unDWwfiYQ3kF/Vz2nz1wqY2Q
         IkrYcc5DulpciSG+wkyb/OT9kf/lNIPd697M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181071; x=1729785871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HcKzCWxvWAVqUtCS9GFF6dDhjA+3HfqRto0OwBOEug=;
        b=rxhruuFMI8GVXI58scY18ooV8dtKZ5Qk/qXUxqPIIeopPwBVhhMEq3shYIRuvuEGtO
         jZ0Lu16wYvof2MQBrtUNkHOmsojBVvQh82yFz8i+xJzE9Uk/Ja0Zb4SJvzbyDbefUSoF
         5r9qv8STCFJF19GI2xfIgSs3RMEOT6uELYGQ2KE2SfWY1kxagXIFjQFCsHMRk1DmA1D3
         D66s2Ybv7Dxd7Ek4Xp7KDNQyW+x2Lj3ENZz+hXM8cNQxr0COC+aqHb4MNcoBTdazP0mj
         k9mlHEbUE6y9wqXZfoe7pA48UVNO1bOQpQ3189CQjiC4YeF2GFFaN/mVE2k7WrcWPTcL
         Yerw==
X-Gm-Message-State: AOJu0YwqvLCzlUJnOLldvo36Aw9YtdHUhHnvnhofsFMgpL6QU0+3yTOT
	fsVR+5jXd69Y7Q4igjYVYz0lQZV6N2z9ebjhQgsp0F0nbj9pLdO597MstdWIoL8=
X-Google-Smtp-Source: AGHT+IGErwQ8mMJoQjk4kVqKA/5LU1jckk232FVcAxJwq7JCrOudWi4KhFaQqDUnaVP7BixbuPz+SQ==
X-Received: by 2002:a05:6e02:1d9e:b0:3a2:5b:7065 with SMTP id e9e14a558f8ab-3a3dc4e5531mr77252645ab.18.1729181070910;
        Thu, 17 Oct 2024 09:04:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b252bsm1405250173.57.2024.10.17.09.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 09:04:30 -0700 (PDT)
Message-ID: <d027a0be-b1b1-4679-89d6-351e0f313e4f@linuxfoundation.org>
Date: Thu, 17 Oct 2024 10:04:29 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: add checks for xgettext and msgfmt
To: Siddharth Menon <simeddon@gmail.com>, shuah@kernel.org, trenn@suse.com,
 jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241017133223.53070-1-simeddon@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241017133223.53070-1-simeddon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 07:32, Siddharth Menon wrote:
> Check whether xgettext and msgfmt are available on the system before
> attempting to  generate GNU gettext Language Translations.
> In case of missing dependency, generate warning message directing user
> to install the necessary package.
> 
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>   v1->v2:
>   - Checks for gettext tools outside the target definitions instead
>   of inline
>   - Replace command with which
>   v2->v3:
>   - Update commit message

Looks like there is more than just updating commit log
in this version. You fixed a problem in your v2. :)

Also when someone suggests an approach and give you a
diff, the practice is to add Suggested-by

John, Do you have time to test this? Asking since you
tested the previous version. Just want to make sure
this one works as well.

>   
>   tools/power/cpupower/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 6c02f401069e..84987f91d11f 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -218,17 +218,28 @@ else
>   endif
>   	$(QUIET) $(STRIPCMD) $@
>   
> +ifeq (, $(shell which xgettext))
> +$(warning "Install xgettext to extract translatable strings.")
> +else
>   $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
>   	$(ECHO) "  GETTEXT " $@
>   	$(QUIET) xgettext --default-domain=$(PACKAGE) --add-comments \
>   		--keyword=_ --keyword=N_ $(UTIL_SRC) -p $(@D) -o $(@F)
> +endif
>   
> +ifeq (, $(shell which msgfmt))
> +$(warning "Install msgfmt to generate binary message catalogs.")
> +else
>   $(OUTPUT)po/%.gmo: po/%.po
>   	$(ECHO) "  MSGFMT  " $@
>   	$(QUIET) msgfmt -o $@ po/$*.po
> +endif
>   
>   create-gmo: ${GMO_FILES}
>   
> +ifeq (, $(shell which msgmerge))
> +$(warning "Install msgmerge to merge translations.")
> +else
>   update-po: $(OUTPUT)po/$(PACKAGE).pot
>   	$(ECHO) "  MSGMRG  " $@
>   	$(QUIET) @for HLANG in $(LANGUAGES); do \
> @@ -241,6 +252,7 @@ update-po: $(OUTPUT)po/$(PACKAGE).pot
>   			rm -f $(OUTPUT)po/$$HLANG.new.po; \
>   		fi; \
>   	done;
> +endif
>   
>   compile-bench: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
>   	@V=$(V) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT)

thanks,
-- Shuah

