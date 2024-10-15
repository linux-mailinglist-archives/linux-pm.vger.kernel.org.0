Return-Path: <linux-pm+bounces-15714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA699FB38
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 00:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A1283F6E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15344185B47;
	Tue, 15 Oct 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IGvfknLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1B21E3D2
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030601; cv=none; b=ehykYcpH4PlD8cDt2vE2LAn29HyyhsfPg2bEdbGONOnxqg2fmufwz1Yp4QDIsusmDbsrGqSNs/KTcZcB/RxvLQ6AvsZX0/I0nFD8LCwLE2pL90dGJKCpfvAIOTscxquR2DXO4jyFe/Ga02ObCI5Qkw/hlMoqPoB8Uw7nMIDW2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030601; c=relaxed/simple;
	bh=CkIkPhMOgzlB/KzA8/OVhY+pto73UGDlKEFhEx4sLEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aipjau/vrkkOk+OR33tQX6PH9MJ34zXGqCyUTArl4X7WmGST5jfFv+q7YwFVrQDHNwTDsF2WI65+K9Niz36X0SXtEZj2XZowjoOol2rwZZ0PfLgYhxedEscKraUheOkNNnAkYIBULEe7hH0PQy/yH/PuhVHWWXTQezbjamAMRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IGvfknLe; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a39620ff54so21719625ab.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729030598; x=1729635398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5V5396hSHL87gEdUlwfvr/5lKm+6erYkMf9B8ShF5KM=;
        b=IGvfknLeO/WT9Irmg8VPnyAVzFjds6sEFNqV751YiDfSa70Je44zO7ZsDQpHtXFpPZ
         P/uHJdAeTMXQY1+wCaJvC4hOLIwd7V7fhjYAqzHrnS753aytcAnYkcJaGlpxTHS2B5gf
         NLcGC2Y4oHNjg+fD9uG9YDfmofkadUbrlWt+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729030598; x=1729635398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5V5396hSHL87gEdUlwfvr/5lKm+6erYkMf9B8ShF5KM=;
        b=GI80fG/1+Sc/H2LTwHGNF8B1iIQ8/9FnWcNqkGho2rfP+58f7sezOGmYjfqR7HuWAE
         v+BvsYpUGnx2qdo2CkGqar9/JUKjUdretaBLiI2yahNQCHaoJiYTBzbxHnz/yClSXgMU
         v/vIx1jPij3MY0NaNFZBbFxJNb6N9kH5P+eEHuDyP2+7mOpa0RXl8/CEGYDt8iuUB9Ua
         j7AE/IWDVkdEv7YnoDIjSiGaTl5FHqHu5roCkKsbq1taNAuWvW1XuWEHLWaEMhCTPXMV
         5a2eX2fqVjDuM68ci7IvqmImOvg93u2ZO6fUxd7idWX1ciQeHW9c6/S7dN1z+bWPilLm
         OA6w==
X-Forwarded-Encrypted: i=1; AJvYcCUy3aTVmE6+RguB9tZTJMv8UktwZ3x4wkXWMqhZ7CW2LW6LX5MBr+ZAlhOa7JkWhNT1IP2VQwgp+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcs6yZrd5ndubn7E7XGJ63HxjtHFUJLOe4614P61RJ8oxvLOyN
	VJR1ubOc9HxXRjVyCcuVyrY9IDaea+Dczum1mVWjKpwAj7BXH4QkgFmcsJX0WiA=
X-Google-Smtp-Source: AGHT+IE1Kulkbi5leWTsG7UZ2nsA2AvXAklVBBregXuM7xhtgYn2RZzeSO90hlWgGWV4CEtCMLWs8Q==
X-Received: by 2002:a05:6e02:20c3:b0:39f:60d7:813b with SMTP id e9e14a558f8ab-3a3b603d198mr154949735ab.22.1729030598069;
        Tue, 15 Oct 2024 15:16:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc424cbsm523358173.124.2024.10.15.15.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:16:37 -0700 (PDT)
Message-ID: <d876dacc-c4b0-435c-97ff-3207f0866a3c@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:16:37 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: add checks for xgettext and msgfmt
To: Sid <simeddon@gmail.com>, "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: shuah@kernel.org, trenn@suse.com, jkacur@redhat.com,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015163854.35204-1-simeddon@gmail.com>
 <Zw6rNVJ1iIjLr1Y2@rhfedora>
 <CAGd6pzOpjEnU-iOeVEmWbaLfWaSQExkEhqREOHXP-7Qkp3AsvA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAGd6pzOpjEnU-iOeVEmWbaLfWaSQExkEhqREOHXP-7Qkp3AsvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 15:55, Sid wrote:
> On Tue, 15 Oct 2024 at 23:19, John B. Wyatt IV <jwyatt@redhat.com> wrote:
>>
>> I tested this on a Fedora 40 server. I was not able to get this message to
>> print despite xgettext not being in the path.
> Thank you for testing out my patch. The .pot file for cpupower is required
> in order to enter this code block.
> 
> Should I  send in another patch to generate cpupower.pot in the makefile
> itself?
> 
> Resending my previous response as I accidentally left text-only mode
> disabled.
> 

As mentioned earlier multiple error messages clutter the output.
How about the following simpler fix:

===========================================================================

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 6c02f401069e..d1171385b552 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -218,17 +218,28 @@ else
  endif
         $(QUIET) $(STRIPCMD) $@
  
+ifeq (, $(shell which xgettext))
+$(warning "Install xgettext to generate GNU gettext Language Translations")
+else
  $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
         $(ECHO) "  GETTEXT " $@
         $(QUIET) xgettext --default-domain=$(PACKAGE) --add-comments \
                 --keyword=_ --keyword=N_ $(UTIL_SRC) -p $(@D) -o $(@F)
+endif
  
+ifeq (, $(shell which msgfmt))
+$(warning "Install msgfmt to generate GNU gettext Language Translations")
+else
  $(OUTPUT)po/%.gmo: po/%.po
         $(ECHO) "  MSGFMT  " $@
         $(QUIET) msgfmt -o $@ po/$*.po
+endif
  
  create-gmo: ${GMO_FILES}
  
+ifeq (, $(shell which msgmerge))
+$(warning "Install msgmerge to generate GNU gettext Language Translations")
+else
  update-po: $(OUTPUT)po/$(PACKAGE).pot
         $(ECHO) "  MSGMRG  " $@
         $(QUIET) @for HLANG in $(LANGUAGES); do \
@@ -241,6 +252,7 @@ update-po: $(OUTPUT)po/$(PACKAGE).pot
                         rm -f $(OUTPUT)po/$$HLANG.new.po; \
                 fi; \
         done;
+endif
  
  compile-bench: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
         @V=$(V) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT)

===========================================================================

