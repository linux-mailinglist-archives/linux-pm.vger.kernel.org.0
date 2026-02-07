Return-Path: <linux-pm+bounces-42246-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIm8L8Bdh2kvXQQAu9opvQ
	(envelope-from <linux-pm+bounces-42246-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 16:44:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C88106683
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A67573004D08
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A68332EB6;
	Sat,  7 Feb 2026 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPMVbx4t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FF33120D
	for <linux-pm@vger.kernel.org>; Sat,  7 Feb 2026 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479035; cv=none; b=qqiV5gk2v7PqI+DZJeIPn/hIJj7XHgvE2A8cbM0hTN/EUB3Os4CggUuUaQwmN0nejgWUbt18Bmz8Hy1wsTnZ/C/wK2Q4/aFOhPE0y7ZyVRouj/MSbX9v9u1yRk66QDQtXeeqDZO59CgURgwsvAtoDaJU4uMS6dgz6JRlYW1/Sko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479035; c=relaxed/simple;
	bh=byBIsVOwsjQTXZDzA+tWozamt4xuZw17YhgQ04xUWWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU3m0yv7wseWOHVZt03y4mUdI7ErE7hr+HNcDhVuH3sg2ckqV97dhf6ypYo8JEKVaImJanxRxbLVTeAodHwzHnKPuXNwAOY+bmxtnx2n+DHmtwlAlmS+q3uct8ZvlJ9y+UMQI//vRaOYh1l7YpAElztrIwIf0zh5wi3wcua59sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPMVbx4t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aad9b03745so367255ad.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Feb 2026 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770479035; x=1771083835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsMQr4WdjXqaOX+upg1OLtcxWMkojCioGYiO35TKlho=;
        b=QPMVbx4ta58Soj63dtmKLXnrLvQ7A6lehR4oLGzVSCPuv14BKV61EHqkFJDuedvVO4
         2972V9tnHjn21wPBWyBpdpEXUHP3bWCd7z1bETS1jTNNmiwWAxsgLk8h6Nr+4u9AJoYK
         dy2+NRspQASPuWumKkV1VrVVsNv5T+QllTDp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770479035; x=1771083835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsMQr4WdjXqaOX+upg1OLtcxWMkojCioGYiO35TKlho=;
        b=JTvWckDw7VI8E+dOHdZWJ+qNbQ/09KbqtcXkTdDVuh7MDWkwwMCFiao2xYuwdVB4RR
         t+IQBIS4STn5M/qXM5IijRvvVJ9B+ELTideEqZBrQduM1a2cdPsdpyiybogmsCaPDbRF
         F8fLa2BaqKloKkiWcAicLuRLOSj6J/fAjaPmR4DPJiRSYjpbBbFqCfuI/f60EouxBUpZ
         yLYqyYEoIyVMgVB1pOC6uvyxZmrmdhfsylHyFZi6wGdl66648TSu7Jdk2U4HlqOBHuR6
         dq3s7mRmg7ybLdB3KRCOzSSB4ctzSz4Wg4kEGgtmLopZXvzTDF/kyMslw4tpDAUAJRdF
         dlFg==
X-Gm-Message-State: AOJu0YxpcPxepXw/OtbW/yHOmVk8BU6pMbe6kHbxdC7Tf0nhsoPNvtyP
	Pk/vF2itg0qsqFYiD/2dmv+Dw9Uyrf6TCMhiuLvd4bxjdXc73DshUwZq92SmIYQuFv8=
X-Gm-Gg: AZuq6aJpANUWp66TnQnsuk9lUCf2CtrYT/wfQvdItHL0+s6gqgRgvvrUaJdp+TyDcix
	qlZFVx2FS5h0CxSr+bMLEfgob2Vgq7vhP2EQ9f8tATAr+uQeFM0iEWlqbUL62ff/4earGsOn7QQ
	U7SieJcsj8a71YX95c2JNqGu9DkK3z+Pys/tiyR13/qdngqB8AStMyDfh2Hx1Y/wKkfL0FI8K+R
	FwrIfFy87pJjn3PIMfaFnlMYvMdvHl37iFaeiIL48qlCRk+7dSZZaDizoo+D9KfCnepX3UJ/9m1
	cKDmb4CP15e4gy00iPNjGhorElvSqLpAO+8Zny6DzQoR1Wr/3dpbILsULs4YWJiMtLJ772GhzLD
	JC3YFTW64uZhAjPWanfi6ZImS3VAplk1eZC6M1XHJ6XlbOml0ubKV+f3ZokxTQlrDAcVwyHmPaT
	Nrl0YYOkpMAgklpN4lu4owltio
X-Received: by 2002:a17:903:234a:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a94119df50mr91894055ad.22.1770479034977;
        Sat, 07 Feb 2026 07:43:54 -0800 (PST)
Received: from [192.168.96.30] ([49.207.181.115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6de0128b6esm1990999a12.26.2026.02.07.07.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 07:43:54 -0800 (PST)
Message-ID: <7280c837-0c2e-4faa-816f-a30b8215b285@linuxfoundation.org>
Date: Sat, 7 Feb 2026 08:43:49 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cpupower: Fix memory leaks on early exit paths
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, shuah@kernel.org,
 trenn@suse.com, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
 <20260204052143.3281063-3-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260204052143.3281063-3-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42246-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C7C88106683
X-Rspamd-Action: no action

On 2/3/26 22:21, Kaushlendra Kumar wrote:
> Add cleanup_resources() helper function to properly free
> globally allocated bitmasks (cpus_chosen, online_cpus,
> offline_cpus) before calling exit().
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Memory gets releases when process exits - there is no need to free.

thanks,
-- Shuah

