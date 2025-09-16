Return-Path: <linux-pm+bounces-34803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15CB7D8AE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658215840AB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FBF323F42;
	Tue, 16 Sep 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvQiXy2V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673F24A06A
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061465; cv=none; b=jc7j67O8gHnjpoSVX0/LfFI1840MRj71Y8YzMRFA4fNad1GnRZwUvOn/4LrwpsJ9vfVsLMXV3wdioy2SUtXnur+yzI66R/CTkb+JF0dFFWyxaPgfFl3jEaITuu4G9ozX3SLlUtbykTFx4vU44cehlsS3rVfsTLHBiEh8Vr9tNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061465; c=relaxed/simple;
	bh=4s4ZgC4M5BH+orbhF6KbIfMqkVLyi01PYlq5QKie7ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DB5GtwhfglOl7CMGYEe6PRHCLhCdGhlg02sEgwt87H5YeU+aMirCZdTadKeXEbovTN6mhdFT0kQMq8QN0BcM2F34Q7EI03EHQm4l7hhW+Xvz9S3p1GxgCDtaC17xrki5QOK78+GhTokvk9/b8ajhL3afjMwmBa2PHC/MUl1AJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvQiXy2V; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b7a434b2d0so21377691cf.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758061462; x=1758666262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GxFW9so94RE+J7EOaUFS+5EFWT1bvxImITo3j0A4OY=;
        b=ZvQiXy2VjAe9SdE208h0UuPB9uvCOQrDmWliVt0u9RO3lD8voV7AI3Crmk0kjxf7DZ
         LKXaim4M55GcrOrhUWPIBdk+S39WGFD8tNInPc3ww1M39scE2foSsZ+bUAsCGtjn0e8y
         1XnoSKdUxQ+IUzRF1kwc6Lqo6Ic8D7w/6ch2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061462; x=1758666262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GxFW9so94RE+J7EOaUFS+5EFWT1bvxImITo3j0A4OY=;
        b=BfMV9OHeM4954+PQc56668z50WYxsAwxIw7ajs162J8ZR2fdVs+YIXDZmUQPM7Vq98
         bavkPaYOqQXRLXK0/JSUlmSBhESB35+hJankNxpClYHtCZi6QRObJgcKFL8CK5z7I3wV
         1Zi7zUmaFa/Zpd5nmMT/j68smb1ZYpZNYQ57RY6IV+MNw7meQmUZzKUwekBkEPrK2uq7
         KZoKi01pLFRSIPiOoj2/fdUd8+BCQyOr1o2enajpEj6zwSscth0bziwW7oOhAKiW9Upr
         yElYYAuVKmMFp1w3bdxyDFCdEmpy0LNYkI0gWz1hKWt8bAY2qwzGsVYdm5Gdd1w6t5/7
         vxdQ==
X-Gm-Message-State: AOJu0YzXQAlIVEgJkNHjJ01S4Ogp1B8evpqB/Y0CbT+OpwAzM4qGzoqS
	n2P8GWE8ZjBdBIEr0BXIxMmenwPDYaAzxPz5vFawyeDnbZFcf5Em1//qJcCr6LA6ydY=
X-Gm-Gg: ASbGncuxQfyFturadMCfHuH0QnM0g8bVnApFRwVqhNe0MUZTOMdDziUBU8usg5Bfqf9
	vRaMxP9xu1w/XGfhq5VwtQVWiTTDlhMqcNXAefhtmhFgXNy+rjAWwmtZP9zLOYa6p2ux/9odCiS
	qNrYRitLc/yUVeiPD0Z052nZVMBQPGDL00prYzwsKNA19W3rzjQJXatelaiNe33PYAxysled9zn
	CW2czE9KV0qLLIjJZmQhfxsbs+eTrJe3Xr7vnGZmEhIaZzAv2M3M4BVC8s6gZf4i+H6FVXsrIz9
	lKCC3Zi+d1iqwAyzCmMr58ErUfn+OXFoLvhc7pYwxhkfqJc9qvzgQrpdJiVZpfz0BpfvOcUN5V1
	iEiPD+fSEeS9Pj8ZweMknkz8Ql+cUdZS4tieNFlYi1CpzqXbZ0Uy4Kacjr1ZA/SFpIeQ1HF9RGd
	6IlA2BpOFGqoiF1jnUfMabFjdITREC+UFH9zZcyIlFQjI=
X-Google-Smtp-Source: AGHT+IFylLwHUsMF4PtSfoDduboaI7wmCV9wKNqPUp+M97cfstrzr6Cc4zmnTg7Ae0XVGUvueURFWA==
X-Received: by 2002:ac8:5f08:0:b0:4b5:d67c:1a7c with SMTP id d75a77b69052e-4ba68715bcdmr1509731cf.18.1758061462232;
        Tue, 16 Sep 2025 15:24:22 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab221sm90414901cf.27.2025.09.16.15.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:24:21 -0700 (PDT)
Message-ID: <0e8a0862-3801-4b11-b695-694f9de7cb88@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:24:20 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/cpupower: fix error return value in
 cpupower_write_sysfs()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250828063000.803229-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250828063000.803229-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 00:30, Kaushlendra Kumar wrote:
> The cpupower_write_sysfs() function currently returns -1 on
> write failure, but the function signature indicates it should
> return an unsigned int. Returning -1 from an unsigned function
> results in a large positive value rather than indicating
> an error condition.
> 
> Fix this by returning 0 on failure, which is more appropriate
> for an unsigned return type and maintains consistency with typical
> success/failure semantics where 0 indicates failure and non-zero
> indicates success (bytes written).
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---

Thanks. Applied to git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git
cpupower branch.

thanks,
-- Shuah

