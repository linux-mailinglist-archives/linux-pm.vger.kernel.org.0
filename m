Return-Path: <linux-pm+bounces-21389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2ACA289E9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5522A166037
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70DF22B8D0;
	Wed,  5 Feb 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXGeTlvF"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5A22B8B2
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757367; cv=none; b=tvoNfXGjXFVwquv9p08YsSsUzPny1TAyt1G+HTZNrrfMq2Oi4/PPDc80jS79cvp6Nz43bGhB1AkvcHm54kaLXmmNvC4bAHdJjGrt2wUnnFwjZVeRCQe2IaQZhfWiMx2rkW1qRIXehCD5w+Ls2rhKGctQUv2O0LcrVs/aNzN3ikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757367; c=relaxed/simple;
	bh=LDhM1BQbzgJZCOl2D+iOUX/VC2C3LFvRV3VuZiTJ94w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VScKtu2tRqBGuEx4an99N/3IOcjF6ITzSS5D72ugnSyUT/ImbN+he/WlpU/IQSucFC2YUwEdUidvFADJvzM3CQ4TMZ5scw4CXQnUfN4ZmPg1GZSCdwo/F61MZbDsA5dQ309kQ9Alcv51F7K7Oya0nc5CZ9ETCEMo5zLd3dvmZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXGeTlvF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738757364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqorq3VqEu/wsOnV6J86n8Ow1XVNycma2QB/zT3uRJw=;
	b=WXGeTlvFkwM/BHLqWOOP/bxSDLIFd2nuqqBt7T/ErluixNVZ8AitsAq3KHU58balOAPk/S
	cvSDXVTorr2oYtL/bfj93hvWf6L94wq27O91mYqxJOzgQ6DStC7/+oSk+JQ+BoyfzjbVxu
	V0KoIEmxXEaK3E0/BZ6HBfUP7JaNQq4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-1WSfzjTFOgaWV8GaCSSBKw-1; Wed, 05 Feb 2025 07:09:23 -0500
X-MC-Unique: 1WSfzjTFOgaWV8GaCSSBKw-1
X-Mimecast-MFC-AGG-ID: 1WSfzjTFOgaWV8GaCSSBKw
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e1b0373bso1114304885a.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Feb 2025 04:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738757363; x=1739362163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oqorq3VqEu/wsOnV6J86n8Ow1XVNycma2QB/zT3uRJw=;
        b=mgbJGAFSFuxHien7d/rkcnPxnybi6tmRuOaDAguuTEx2rYjgTdKJM7AsirWGdYH3pP
         7xOz5AaXF0Tps5EAVowiZOg7upFHMbDvGBf14LWE5CX8/08QxGX6jBkDrdbxzaDZ5WE7
         UIV581eFGMs2X9riynSCRKJrv1WuVLHK53WFauAYOSvbADlATWFPphBfpSR6EDRCndhT
         vGLAWcqqrtNMM7nv6TtNdHX6w6scQrZL8PHH1VokkleKuaPsNgeuS05p3RjSszrMDAVk
         TdzcRHSxsV2C9QqIwDKzP/v15Lm6gH3Fq+70wsChKZ5qhZhGHA+Rtsw/rdB+EgcU6nGd
         84gg==
X-Gm-Message-State: AOJu0Yx30C6DJKfu9xKB7Rc3NxLkjpuniRmSWCTNf8dF/PcSHYtjC4Sf
	hAcSuM9zaV12Z9g1u28BMKsts7BRivPCXKfh7M8d8fAEE0BAD1JHWSTCpQ0wY5McC3rSwzhN7ku
	IllML7Y3PxWP86Wgr3ypXNk3hPAOdpjX7+CHypnayQ91STQbCBjjLjSUn
X-Gm-Gg: ASbGnct35iLmKEclaES1PavsVEiP9p8w6KWKYJwFTfFzOQwMB543wNhyILq5z/8ftwy
	9p9ReImoSr6JLoOb5WjI90lNG9i0CWpdYDWpsWcZYBbiftfjSiDiyaOi8/kKMwxb5fkZoTKoMWp
	FA7qz/0Ciw5bmmHZuHEGZsf9FX3MZA+wfn9y6NS7pDNHfS47Wiu1oqfI1p3glmHo23/MRGoVMkD
	pVWlBH9N2ijX30STmBomms7rlow2cnAAhOxPph/1yK4598teaDG+uS6MT41ZGfB8L2v/6FnJlcO
	sdYI
X-Received: by 2002:a05:620a:8905:b0:7b6:e9db:3b21 with SMTP id af79cd13be357-7c039fd4a7amr350587985a.14.1738757363191;
        Wed, 05 Feb 2025 04:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8PXyJhl1DaAL6BKHNBlLuayS4yGl4Jjz2cYcxmO+tPT+BXqNI9LVpnE08fvB9D/gtSMRQcQ==
X-Received: by 2002:a05:620a:8905:b0:7b6:e9db:3b21 with SMTP id af79cd13be357-7c039fd4a7amr350585285a.14.1738757362905;
        Wed, 05 Feb 2025 04:09:22 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90ce2esm742414585a.103.2025.02.05.04.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:09:22 -0800 (PST)
Message-ID: <e2eabe42-45b8-4930-af55-857f6e8a4317@redhat.com>
Date: Wed, 5 Feb 2025 07:09:21 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
To: "Rafael J. Wysocki" <rafael@kernel.org>, dedekind1@gmail.com
Cc: linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Len Brown <lenb@kernel.org>, Prarit Bhargava <prarit@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250128141139.2033088-1-darcari@redhat.com>
 <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
 <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
 <CAJZ5v0hp8f3Xjb7bkDR_+RYfTE1ck=qop_QMZ3+z4w7T0VS66g@mail.gmail.com>
 <c3f03a5837e191c5371593ac0a0e3c56e4204567.camel@gmail.com>
 <CAJZ5v0gKsqrruwSBQLk_1cC8MMRyznzE-FbsqDyzs7xFMgZoQQ@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJZ5v0gKsqrruwSBQLk_1cC8MMRyznzE-FbsqDyzs7xFMgZoQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/4/25 12:33 PM, Rafael J. Wysocki wrote:
> On Tue, Feb 4, 2025 at 5:30 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>>
>> On Tue, 2025-02-04 at 16:21 +0100, Rafael J. Wysocki wrote:
>>> But it could be something like "prefer_acpi" as far as I'm concerned.
>>
>> When I see "prefer_acpi", my intuition tells that it is just a preference:
>> "prefer ACPI, but may be native too". But I understood that the patch is about
>> "only ACPI and never native".
>>
>> The reasons I suggested "no_native":
>> * Sort of consistent with "no_acpi"
>> * Suggests that native won't work.
> 
> "no_native" would be fine by me too.
> 

I will send out a v2 using 'no_native' for the new parameter.

-DA


