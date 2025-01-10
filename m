Return-Path: <linux-pm+bounces-20175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55FFA08488
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 02:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B7A167C08
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8F62BAE3;
	Fri, 10 Jan 2025 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="MLKULT0W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D7539A
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471623; cv=none; b=hcnNK4uUETr73oxQnVW7rAbvKm8Mn+OOsA0WrM9F6LgB7S2ITTJZvqOVunXERdeSU2mDmL1SKn1o+LnkAl+emQxztdvQunQsFPbnmGHCE8f1c9z1aojYc4BaMHoeI9grgVp8Ak3HtCCrM5qTO1SzM6sqnJEF3YZ0ktnahuY3/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471623; c=relaxed/simple;
	bh=+CgXAtMojwIIhf+jTTcBilvCFgsiI16P6JjkqSzmkic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUFx6vdp8ZEy2tfTqRI5cUtVXuPUchkO10QAD5TbCv4V7HBSbd4U8mk8Jq+JT10deMA5dBkQTe2F5nYf3SypQ+8cTnfAxZQ3XWWhpP+NmL8VG6CdkYQiAF5iNgVSh57BHkq1VkC8jglt5FsTaBnicrMsHZh7+ePgxM8WoDnDhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=MLKULT0W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21634338cfdso34549765ad.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 17:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1736471621; x=1737076421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DjPmDXgMDBTgnIwJ02Grcz60cHw9V7uf7ucFpJhnJQw=;
        b=MLKULT0WvWEOyOrQ/7xf1nlbXLE/oH821sDgPa4bbIxSh0IHUyk/SSsmQWXYch9zYl
         lY4YOc4zKgGdviuXhdPVBG3pJSVoVNCOHP4OA/ZtTLkUbveSy8fZmkQXAQYFDDKdPgMk
         J2sx76dQ4Qrg9xhDcrST11CfS759zmXeGtAG6JzUPFqtJYuEWswA7ZDhYI0OcnjTDXRb
         D+9RYPeFh/X3/jVhVnmPuD7VKXz1hnQPuGlVGd5lS6SWfkhim+1ELpyxYFTWC0vKAprn
         1gBxRktNkHXOFOayxUn3JDmlL6k4rAeqyamWA/XhnznalbjAfD3dfQojKgJdpYNHL/+N
         iH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736471621; x=1737076421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjPmDXgMDBTgnIwJ02Grcz60cHw9V7uf7ucFpJhnJQw=;
        b=ChWrLs69e0cJcCHlZNpSKjJP9PUQJ649OZdsabyG+zcpCUddATYwaVKVOx0MqoG1A8
         Y9g4dBnccxyrEhHZCJBwrPHW8zRtEr6nuOyhRFdRmKHBVPVnJ+cU5v70lKSZ3bdKr07p
         6zg9wXb4AdxcHjtmi0uuKVs+5LE1zQ035jRB2Hj3kohBid8L2Y4YuPsBsPDLpRqKvaRf
         2l9ixzA2Zhgaz51MSgH6fUdNV1h7N1gwcn4+Jp31FbTlweqvIQX+aS794+k+IG2cyAg6
         wuk67tO+knbvxtF7pIOQmFIs2DJshnrCIEYL/1PqoQatJbRNQ86zsYgQ/fpqrujNln/o
         9duw==
X-Forwarded-Encrypted: i=1; AJvYcCWY/c/QcKiKKOB7WhFJgZpWIrH1pIIBimJmR7XWaxtmvoxFL7PEtkA7EHuDC0uM9QC4D/TOBB27Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRXKWzYKrd0387yR86sA5lQ8KNWfOundON1ufNzSTSUuIEfet
	AjF0/tErM4KnGu8KZS63DC3sbvszh6l43ewqw4PjzJ9wQbluRso0Ry7Ckf3tJtM=
X-Gm-Gg: ASbGncvB5ewb2vYJFUMEybCzyQVKsDjRk+AbRABgxSoKpU0loEvn96KX8FyMkKHYBJx
	ypyk2k+OeWYIDM/U5FkZ4ygqtbwXXDJXxk8NdR0L96wztAXEN89jDRvwE4QvOoq63mOy/kiOFa5
	KxAzqX+8E5FuYRg7/7CM+rdbStkUb8+9cgPXmVt9OjYByRWFob6G3fxzDLnyG1uxBteao9WaSs+
	Us6Rk4fa/sHnlXRbsNMMDP9GxloZgolbxs/x4rIQq72semGcD+EidHQAuZ9l3wVkNUPh9z2httw
	UYcUFZz0ZDgspRe7ZdJmtZr849SAhWra53Qz
X-Google-Smtp-Source: AGHT+IHaLUiTwIrvlEsIvh+hJM+h6Cc3uuniHsw5qZQd71heT2rgBMRg3lFOR2OEtF2PeDPqV2AUmA==
X-Received: by 2002:a17:902:cf09:b0:216:401f:acd with SMTP id d9443c01a7336-21a83f527e4mr141734785ad.21.1736471620728;
        Thu, 09 Jan 2025 17:13:40 -0800 (PST)
Received: from ?IPV6:2001:f70:39c0:3a00:cec8:c8cd:7a1f:b1b8? ([2001:f70:39c0:3a00:cec8:c8cd:7a1f:b1b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d22bsm3900535ad.189.2025.01.09.17.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 17:13:40 -0800 (PST)
Message-ID: <87e46b70-d100-4ced-9b77-0d30eaecbf2d@pf.is.s.u-tokyo.ac.jp>
Date: Fri, 10 Jan 2025 10:13:38 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] powercap: balance device refcount in
 powercap_register_control_type()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-pm@vger.kernel.org
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
 <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
 <CAJZ5v0h4TUvGKKD51U+RUWv0sCbRjon6PF3ycVaTHMoA=1VEVQ@mail.gmail.com>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <CAJZ5v0h4TUvGKKD51U+RUWv0sCbRjon6PF3ycVaTHMoA=1VEVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for your response.

On 1/9/25 20:39, Rafael J. Wysocki wrote:
> On Thu, Jan 9, 2025 at 1:36 AM Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:
>>
>> Hi Dan,
>>
>> Thank you for the report.
>>
>> On 1/8/25 19:11, Dan Carpenter wrote:
>>> Hello Joe Hattori,
>>>
>>> Commit cae442480e40 ("powercap: balance device refcount in
>>> powercap_register_control_type()") from Dec 15, 2024 (linux-next),
>>> leads to the following Smatch static checker warning:
>>>
>>>        drivers/powercap/powercap_sys.c:632 powercap_register_control_type()
>>>        warn: freeing device managed memory (UAF): 'control_type'
>>>
>>> drivers/powercap/powercap_sys.c
>>>       622         }
>>>       623         mutex_init(&control_type->lock);
>>>       624         control_type->ops = ops;
>>>       625         INIT_LIST_HEAD(&control_type->node);
>>>       626         control_type->dev.class = &powercap_class;
>>>       627         dev_set_name(&control_type->dev, "%s", name);
>>>       628         result = device_register(&control_type->dev);
>>>       629         if (result) {
>>>       630                 put_device(&control_type->dev);
>>>
>>> The patch adds this call to put_device() based on static analysis but
>>> I'm pretty sure that will lead to a double free so the patch should be
>>> reverted.
>>>
>>> We can see on line 626 that the class is powercap_class, so
>>> put_device() will call powercap_release().  The means that control_type
>>> will be freed.
>>
>> Indeed, I missed that.
>>
>>>
>>>       631                 if (control_type->allocated)
>>> --> 632                         kfree(control_type);
>>>
>>> Use after free and double free.
>>
>> Instead of reverting the patch, How about removing these two lines to
>> avoid the double free (so that mutex_destroy() is called in the cleanup
>> function as well. Not that it makes that big of a difference though). If
>> that is ok with you, I will work on a patch to fix it.
> 
> I'd rather drop the commit in question and feel free to submit a
> correct patch for the device refcount balancing.

I have just submitted a new patch addressing this issue. Please review 
it and apply it if it seems valid after reverting the original patch. If 
you prefer that I send a separate patch to revert the original one, 
please let me know.

> 
> Thanks!

Best,
Joe

