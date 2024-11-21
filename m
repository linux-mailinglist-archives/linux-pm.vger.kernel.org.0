Return-Path: <linux-pm+bounces-17847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C39D49AB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4096B209CC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94381156257;
	Thu, 21 Nov 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIqnNw1O"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFB4206E
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180427; cv=none; b=qGvltOZ5tVHrYRQ3apHwBrYppG2ZUE1tqIh7iNuJaV2oVhGfvKrD8M7BtYIMBPt6AgThwcUJooHD91SoHDRECy7YpZ3PWf3dFTtMkW2j9uTvcljj7obsqpKmiGDWuWSpepD24nYgGNpvhdCmQ3JbqE+5Nz8+2GHVBvcAcmycVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180427; c=relaxed/simple;
	bh=j1ni/ZF2MuZrJhQziqQzGU0E/o+qR4N9EUTb+6Dzybk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=feGQXw4EIS0bZ+zx/X6Tw3oiQADAETEYyyOWGotH021QXlsvfQp2wORgarcf3LZkYnlhUSv2uNU02xYQjatLsildygb2L+1L7KZ0OIrVTQdk8qOKbkva3SvqjclxjloMZ4w8GBOgZyvNF/zPe/8JX6vkV1y4NM+O9qBZVXnxOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIqnNw1O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TVU6dOdHgXa7ca0/1yccJV58KOLtpVIKmsRtBn47G14=;
	b=MIqnNw1OzQcqXHFiMXT+NfzYeJffUsQWpEqSk2M9QSIQvnWYakTV1boQD+pTvZFZS7OAhV
	eY53qmIJs1A4B/jwpkBpE1yKgZ0vX5Wbuc7YUKrITe3sYQjpVauqwHssJya+0sEvzNNwg9
	5f6myLyLlx3exrQQdIt8sWG1UQ8i/Rw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601--d2nfD4WPoSJzcXgP0g4HQ-1; Thu, 21 Nov 2024 04:13:43 -0500
X-MC-Unique: -d2nfD4WPoSJzcXgP0g4HQ-1
X-Mimecast-MFC-AGG-ID: -d2nfD4WPoSJzcXgP0g4HQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38243a4ba5fso456324f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 01:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180422; x=1732785222;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVU6dOdHgXa7ca0/1yccJV58KOLtpVIKmsRtBn47G14=;
        b=V64dPjRzYk+q/hU6mMZzYC+zQhr7KQoA1jTenybAfEneFNzRKnJQUE4x3aoeB/Kwca
         wGLj4tyrNSObTK/uEbrAlBNcbTFOqI9yfhWAMiYX+IQBbyl5+x8RloFe8TtSyI/CpKLF
         FqzC1G3MsE1eK+nDdozajrgIlZQ7Qh+FtTpdweT7KB6FfkrccvAL2T1fcpBpjxLCvFwv
         XbV18Uka3/WnCSSel6tkwk8mhiDmE596NK0n4eak6NjpjBQqs5d/o71Pbs86I5tF5ump
         dcJlE8uBA4qlJwyXEUy6oN8bA3ozTTF/T28IQVeRepxWgweGjfwbIx4ThNqxi7QpsL1B
         OjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9F6rspIKges1YkH9iGkrFXkDSKT51GKZsaxnf16yjSgtf+Co213G4cx0JA7Mkj8nimd5RS10k4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IytcETS+4FmZLG6N51HgVKzFw57lhS+asSOagCODTEBFbFmw
	zdyUzoCUjPU/Pjj9JQl41UygLS6NVasfH26IyKIfdgGRBWDqBeeqkgYYLFWbbM8F1vnZ0WxptGP
	Um0MPlkhMohLgkc6L1VDjbv/02VA8U2iWhAdW9/m6cD/q5XlDrn64UT9t
X-Received: by 2002:a05:6000:2d82:b0:37d:47e0:45fb with SMTP id ffacd0b85a97d-38254ae58aemr4123931f8f.21.1732180422230;
        Thu, 21 Nov 2024 01:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcoOKVS/0xu22BYIQFC4w0iVaVFl8M24yPG2Zxq3749kJDh9nLPV5RK/WbTofCrsjui8L2bw==
X-Received: by 2002:a05:6000:2d82:b0:37d:47e0:45fb with SMTP id ffacd0b85a97d-38254ae58aemr4123917f8f.21.1732180421868;
        Thu, 21 Nov 2024 01:13:41 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490529fsm4440294f8f.4.2024.11.21.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:13:41 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh@kernel.org, arnd@linaro.org, linux-kernel@vger.kernel.org, Radu
 Rendec <rrendec@redhat.com>, Zhipeng Wang <zhipeng.wang_1@nxp.com>, Maxime
 Ripard <mripard@kernel.org>, javier@dowhile0.org, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
Date: Thu, 21 Nov 2024 10:13:40 +0100
Message-ID: <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 21-11-24, 09:52, Javier Martinez Canillas wrote:
>> Will autload the driver for any platform that has a Device Tree node with a
>> compatible = "operating-points-v2" (assuming that this node will be a phandle
>> for the "operating-points-v2" property.
>> 
>> For example, in the case of the following DT snippet:
>> 
>> cpus {
>>         cpu@0 {
>>                 operating-points-v2     = <&cpu0_opp_table>;
>>         };
>> };
>> 
>> cpu0_opp_table: opp_table {
>>         compatible = "operating-points-v2";
>> ...
>> };
>> 
>> It will autoload if OF finds the opp_table node, but it register the cpufreq-dt
>> device only if there's a cpu@0 with a "operating-points-v2" property.
>> 
>> Yes, there may be false positives because the autload semantics don't exactly
>> match the criteria for the driver to "match" but I believe is better to load it
>> and not use for those cases, than needing the driver and not autoloading it.
>> 
>> > I am not sure what's the best way forward to fix this.
>> >
>> 
>> I couldn't find another way to solve it, if you have a better idea please let
>> me know. But IMO we should either workaround like this or revert the commit 
>> that changed the driver's Kconfig symbol to be tristate.
>
> Yeah, this needs to be fixed and this patch is one of the ways. Lets see if Arnd
> or Rob have something to add, else can apply this patch.
>

Ok. Please notice though that this is an RFC, since all my arm64 machines have
their own CPUFreq driver and are not using cpufreq-dt-platdev. So I would not
apply it until someone actually tested the patch.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


