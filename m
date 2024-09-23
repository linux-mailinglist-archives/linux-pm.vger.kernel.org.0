Return-Path: <linux-pm+bounces-14574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F1C97EDD0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97540282007
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436819DFAC;
	Mon, 23 Sep 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLXL/g1E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332119CD12
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104190; cv=none; b=eLwFVkKK3ag2u1WMQ4qPNH+DiSaLCPEYtXfxqsztU59h0QLPbv98nDClCqhc9NMxIpnLPtoK0h3iEBzQZQ8Zx4ThIeBIM0dMv0eC/HCwKEHea4di7nwSr4mWm/jfdDzbPCnVv0OH8q7ucJyKSPB37OCwbQ+tM3UjCgJCz3OVolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104190; c=relaxed/simple;
	bh=MlhF8ehNpI88dBp1nv0Vi4Pyk5dAvOsVXpOwtTVYI/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGhXX8pr2mxr9miFkhRSGMmXJPXqfRpf4LwNrJGW6zVeWFfdFYYxOWZHiVhe0nDzLLDT4NmHYTiXBJLLlxtUvVif62Ue19UqRrK8IrNzxsQ/KswYjUu+18bgb0GxdAIBJnD6eT4LJLvrINVq7w8UP7ZOZlXEmHzQFKZwJQOv54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLXL/g1E; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a0cad8a0a5so17046985ab.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727104187; x=1727708987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ti7v3Fv6sTAv0PRGJJlgJgiyxrO+5APnMuVBlCHcds4=;
        b=FLXL/g1EEnDO0QBP7q0To7XwSaBGCHIZYA1LlalIawZhQCV4TtpSgfubR+eOA2SO59
         iCdNSa2saj54Jm7HEsNDs443J1Zsqqo7E4luvKJPJH9/3FkQYNwJ7T+IFd/y4B2fM8a4
         fQRI9FVFCk5IkqduEcY/1208kpvH4eE4lnP+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727104187; x=1727708987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti7v3Fv6sTAv0PRGJJlgJgiyxrO+5APnMuVBlCHcds4=;
        b=WkfKgVwOiZ9EY0FHU28cpVsMdyC8qnbsH66jWb6a4+VpDLdADv7lz43hz4SgdxinYZ
         Mpf4X8r+HtCIIF86le8uGJnmLg58V01uAbe5c1frN4KDLI6xBDEU50DpTylVjz68LAHe
         ESGK3Qk/vaOXOlzxg8smOBQpNiCU9zG3suIZuSggcTKbCQCBVwQbQj26Fo9en+9KHHkw
         XvC8flf8Md0mcHyTUcYu6ta0CQ6LF80JznERbbaOMtwSmBIkUHubWNWxkrxQJ313yARe
         F36ahxvYfNuN7xnBx6pywH3rMmBKKSaAfE4bTNDzlkstDIWxMMwrdhKEcTr/BkFzhvRb
         edng==
X-Gm-Message-State: AOJu0YzBjJpbjK8QspXwHG2wtxUnZtjjOdYXf+V/ABocTR/JuD+oySM+
	0CCJnbnOjGYkm8x0qCVqflDJMu5TOJ+3wLNXmruqDgdO4VviPJS85zUMXggNTUc=
X-Google-Smtp-Source: AGHT+IGVEsquzlM9GoMVthtYSTofa1uUH3CuC0IK5mwuQqFAaLQIwX4GCYrj62qn7WM+7uXx7NF/6w==
X-Received: by 2002:a05:6e02:20ea:b0:3a0:9179:7651 with SMTP id e9e14a558f8ab-3a0c8b982demr97956755ab.0.1727104186559;
        Mon, 23 Sep 2024 08:09:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0b6e604f7sm39552135ab.61.2024.09.23.08.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:09:46 -0700 (PDT)
Message-ID: <ab02dafc-e181-44db-bdaf-ae5ff9e01f38@linuxfoundation.org>
Date: Mon, 23 Sep 2024 09:09:44 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pm: cpupower: Clean up bindings gitignore
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919195626.26833-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240919195626.26833-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 13:56, John B. Wyatt IV wrote:
> Add SPDX identifier to the gitignore. Remove the comment and .i file
> since the file it references was removed in another patch. This patch
> depends on Min-Hua Chen's 'pm: cpupower: rename raw_pylibcpupower.i'.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
> 
> Changes in v2:
> 	- Rewrote commit description to use the paragraph format.
> 

Thank you. Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

I will send this one and the other fix to Rafael late on today. It will
go into rc1 or rc2 depending on the timing.

thanks,
-- Shuah

