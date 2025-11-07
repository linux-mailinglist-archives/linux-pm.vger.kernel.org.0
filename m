Return-Path: <linux-pm+bounces-37617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BEEC403CD
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 15:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1624F5737
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3073327798;
	Fri,  7 Nov 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m54AXq6O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C6320A38
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523847; cv=none; b=kNxBsMvfuztvTDwQCCwwANfY4VtbWaBaA3Wb9tvrZUDZ3veVsN5TwbphGeiqIWZMHSYsHprWdxe7B4pZREjSBuOjb/LSHLu64Ir4k3rdXGdq1s/o5ofcvfba3w1xDpRsSeY7XteE1RAU4VkCQvjzLmzFTDHRzydZrri07TBisFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523847; c=relaxed/simple;
	bh=pU1/d3gTQ3oOdrNMuwLNWQMPQlhrormAWhdG+nQqqZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcqLVlJ7gtzhrK/9fNTkkJdS6Qp/1Sznb+K8nl/aLALg77fzs2gvchxego0TpWbYfLo09biOCZZ/EU6G3+9cM3eMOBu2bV1/nrKYS/HNL/VgXDKMCbbzRRetRCJd+Dnp/tZRb7KiPwNGM8DxPOcYR3Btr6Ue1fg8Gwpwtn6DVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m54AXq6O; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37a3d86b773so7799671fa.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 05:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523843; x=1763128643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmTmsZO+E5ineqtVbOXnuX3qzTxvM93F9HyZ2/MV6QE=;
        b=m54AXq6OPUT/DAxGH4PVrpXzN0MqFPPWaCfBPchovIRCdVYeGUcPBSKroXiNMY/1JF
         vcnFJTBbhEpnewuMK3IG6Kv5e/51bgUfk7ZmlSfGWOddsX7sbgY1LxZ2X2M+mYuftXk9
         ReAucveDqxqK2pxoK1nrbylv+nbYdRe0kPvGhJBhJ0Z/TshFvP1pkSaKfYa+h8v/Qpvn
         5RUbppmEBthm+uw7uxj2N+bPLYT1pgXwgKdUQwZgsLmHo6p5MrE1VlTM6hr7zS4axNbB
         i+SJ67Pj7B8JTPHy3Dos5eoft1g/g7DJmHOC256vP3Y6jp4wKwBbekRCQhBQXSXpOVJm
         FIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523843; x=1763128643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmTmsZO+E5ineqtVbOXnuX3qzTxvM93F9HyZ2/MV6QE=;
        b=Q48FdKQ1g1iiXSkwZpsQrzWPx/m9iFqlLlTRt2jD1NP+GChmvjmdaHrlUnMALPtIah
         kZg/0Xf2UZV2TnKSbWLXKL+PX5Yn+V+CWAdbDYBL/CowOkAj6GSHrdF/rGZtfOtepcvN
         hS0FhxgxB0LjR9lohLJhcqfZbZY2eFjmIhU/eUFehR6PnJ8SZVwJTZATwwXuA11ImAme
         hW4EL951TWm3zE2mjXMTuCVBQH+OAgN9k5aImxjvE7shiOj168mphHGZ6B6ruY5yU9UJ
         XgOn0Rz5lsBC2UpE6+v1GDziiLTFTSyg5r1+N54dvK9AUendTs/BIE7myBwZ+zlVFxjN
         yJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5AyPd9IifT3GjmeV+3Z8XIE0ZvjTWNLBcJ3QGtj0gvYgAJlXt4d+UbIEmMRjTy5h9tGsbBEuXsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXeL67rkZUUT48qqEPxGE3CNmgZqij2vwAMyAH5gEIj6/oVMP
	5JdBcltNzeEoVb6GldStTWzWwoak9nNXSbVph6ktRe8V1AmuzHRXNNhwQn1swZCmmYM=
X-Gm-Gg: ASbGncuWtUpmLt1JFcVopqjNYi822MYVAe47dTc0vuaaOEghc781+ZlVaRz0ZcwuAyM
	nfD6bS1mM5hcFvXXSqf8QBNF3zQ7trVj4Sspg7T++2mEuP+VMPgdTG87K8RAOGb9ELf793rJ+e8
	3tAp3i1qDkgWvnoeC8o8MBhztSYEmq9plg1ZoXk2Hn92r8EeO8bYsaIdtCzawqwsibKlaSikDJq
	yUMSNow0rti8ejcUF1I9RIdGSlPTHXSOxj6GM3og1ywYNvaJ1kPFok4FpTwasp+Du/WJkjruLE1
	SiV8aJqDmhxyYKniaU5ORGtF21/HOAcMuwtVPJ8AhiftIwTpSR1TwAZvBUxZ3V4nfpKJ4JfZNw/
	8ci90XccNhV9y/wBSdw6+96HBnpZ+2ejizwZIT9dzRoH8M+1E5AHYRBglrFhUBwFPgQAAsU/4io
	6dKDCunQWS7yFXUq0yrgsECdoa2ZY/BoMvl8DH7a8GPCeIEGzuAxBHLPtBKA==
X-Google-Smtp-Source: AGHT+IGuna97US5S+FEJvdQXB1ZSmKd9d9FBrPTuZIikplId7oOFsTN/OD71KzPyK4H+bf41lFXeyA==
X-Received: by 2002:a05:651c:110f:b0:378:ec26:bac with SMTP id 38308e7fff4ca-37a7312d659mr6724151fa.15.1762523843126;
        Fri, 07 Nov 2025 05:57:23 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0790a7sm13094511fa.22.2025.11.07.05.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 05:57:22 -0800 (PST)
Message-ID: <5189f05c-136f-4ad9-b309-159607e6e930@gmail.com>
Date: Fri, 7 Nov 2025 15:57:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ROHM BD71828 CHARGER
To: Lukas Bulwahn <lbulwahn@redhat.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2025 14:36, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
> adds the file bd71828-power.c in drivers/power/supply/, whereas commit
> b838cecc2291 ("MAINTAINERS: Add entry for BD71828 charger") from the same
> patch series, adds a section referring to the non-existing file
> bd71828-charger.c in the directory above.
> 
> Adjust the file entry to refer to the intended existing file.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

Yours,
	-- Matti

