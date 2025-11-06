Return-Path: <linux-pm+bounces-37566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D05C3D6F7
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1241889111
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0203009F1;
	Thu,  6 Nov 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAaCNgFh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A92FBE1C
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462605; cv=none; b=X9VrX8uuDkGCt2smcm0UFvucAqKuJxk0xRnA2ONLBbS7G7/7lxfilOYwau1xxlhdv631k8sJ3r1uOoLtMuslmtaPWXszPLKEwQulDs+vhSBtKZYEdMxOE4aqMRSjKYSrOnMmtl7JhLt8xzssazmQKQkh27aoHJBSgoK6QYyao9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462605; c=relaxed/simple;
	bh=fc6M/Dt13W5E/V0Y8tcAUj58eG4bfC0RABMJ3HlAj7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjvnEiB7Rj+zlxBEY1Cer3LwOwoG5X9I9I/TeYoMfmZ5RVgzVPgv5o8zcRvD2NjBAVi38Jr1YFUB1S5/pN65nbW/tyfyMr8GwLw1Y4KODpJ+lu0LU29sXVDg1YQ+6nurp1Pj+MtTAJEH9Q0ae6rIoZhYCurQyPrMBeX49/UcwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAaCNgFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65959C4CEF7;
	Thu,  6 Nov 2025 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762462604;
	bh=fc6M/Dt13W5E/V0Y8tcAUj58eG4bfC0RABMJ3HlAj7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eAaCNgFh5Bp835ELibw1OUkrtLrsSDJnvkDNzN1V7p5R8mSrZL5k0U+YirafLvLwu
	 O5OfWWSpcz5fN1HXj1me9NxY6kxPAQ3irjKJx6+k5HlXQyZeGq9fac9YjIP9nu5hOz
	 fEbSacVRbQ+ePEqB/iPtb3EHsw+hnQtFQzDhSjmbpwhO7hXObh1QF8fqwX781NCFsU
	 Ql+V1Ve4fW6Or2bhpX1ea0k/xoOuRhyqFa3gLqc8dfRanEJprANJZlF+HPVeXyMpLq
	 BlVHTqx/A2ajSQ631rSuXcG/4QGVo0IgdPxUbbX4Osz5G7ZGf6s+ohDnRD9ZBBUXPE
	 amk42jVKbdwhw==
Message-ID: <407f358e-dba0-4079-ae03-0104f4b0190d@kernel.org>
Date: Thu, 6 Nov 2025 14:56:43 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fixups for hibernate issues reported by Askar Safin
To: Askar Safin <safinaskar@gmail.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, mario.limonciello@amd.com,
 pavel@kernel.org, rafael@kernel.org
References: <20251106045158.3198061-1-superm1@kernel.org>
 <20251106200356.8213-1-safinaskar@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251106200356.8213-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 2:03 PM, Askar Safin wrote:
> "Mario Limonciello (AMD)" <superm1@kernel.org>:
>> Askar Safin reported some usability issues with hibernate messageing in
>> some failure cases.  This series fixes those issues as well as some style
>> issues I noticed while touching the function.
> 
> I tested in Qemu. Now everything works. Thank you!
> 
> Tested-By: <safinaskar@gmail.com>
> 

Thanks!  I'll let Rafael pick up the extra tags you had for the patches 
if he agrees with them.

