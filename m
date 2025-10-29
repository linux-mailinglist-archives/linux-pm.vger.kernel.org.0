Return-Path: <linux-pm+bounces-37060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1CC1C5B7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7836586D72
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF75348462;
	Wed, 29 Oct 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1i6Bbq6c"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E634CFCC;
	Wed, 29 Oct 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757284; cv=none; b=TFJDl/faGBituMyF4Z3ssRYnkCWIX8iK4N5nCJSR2Dampsg9FmJL5QTYhyC95kNtoUoAO3Ho1Cn/8HLEceQkDGAr5F2hshTycP53PJRb1IXpEqrbXNwmsnTOcVh1+sRNPShD2dv5Ur16Z/wZMcEjRUFu0CdIaQAQykl8EWhCxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757284; c=relaxed/simple;
	bh=NZJYysHiAM5CyJPbZNHUi54aIKJJhG8RzrgvEH1LOwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI088b++8wrZgdKuA19ZIwScj+yKMvDifdwNyEh/fgts//8OpmGF/E5DPCV6qMhDSL0gDRCgH8fyO3+8JQaUpBo7IkFdGvmh3A5/5alNnHNRbBwo46X1FPvFxUBacVBRvOkwYEm76OCAhuDry58EpL6MW4tiD/TqnntcbK2JEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1i6Bbq6c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=atzT68l7oLan9uOLNG+v9Cm7uq3EwwtnbjhWXxRE+LA=; b=1i6Bbq6cmEfmZDARMgVoO6aL8T
	5PEjHQj0cYfOADiNuwt1CMbUAbmBbY/BRGj45GQcOXEOMNL776Qua3alx5hxHYCJgZ7/m1GLhwHaN
	KnqK7hzX9mhouNgMKacZtOdrAUpiQEzvkvH0jUYTZ3xUhdcx+mXwZmYeF1bGolhGEirwlSGHueAxC
	GQesIuXn741YzoGqOzsv9ociE8+6UnGsdVut6eoeabKXE5flGEiJy6y55UsIcabpYFoHY+S7I4DRn
	oL5QnJcdAqTAw6oYxJ7h9bxmw/0FzSuLbv3JgZZM6SCOhACdx0t+DQbJH/5snG2HtPXnBuqyoAT8G
	YqCAbtHw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE9Xz-000000027lK-3kSi;
	Wed, 29 Oct 2025 17:01:19 +0000
Message-ID: <81b03d82-6dc7-4af1-bca1-3632e1a0b4c0@infradead.org>
Date: Wed, 29 Oct 2025 10:01:19 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: pm: fix duplicate hyperlink target errors
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20251029134737.42229-1-swarajgaikwad1925@gmail.com>
 <aQHyhU78m-9RPQ8q@archie.me>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aQHyhU78m-9RPQ8q@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 3:55 AM, Bagas Sanjaya wrote:
> On Wed, Oct 29, 2025 at 01:47:37PM +0000, Swaraj Gaikwad wrote:
>> Fix reST warnings in
>> Documentation/admin-guide/pm/intel_pstate.rst caused by missing explicit
>> hyperlink labels for section titles.
>>
>> Before this change, the following errors were printed during
>> `make htmldocs`:
>>
>>   Documentation/admin-guide/pm/intel_pstate.rst:401:
>>     ERROR: Indirect hyperlink target (id="id6") refers to target
>>     "passive mode", which is a duplicate, and cannot be used as a
>>     unique reference.
>>   Documentation/admin-guide/pm/intel_pstate.rst:517:
>>     ERROR: Indirect hyperlink target (id="id9") refers to target
>>     "active mode", which is a duplicate, and cannot be used as a
>>     unique reference.
>>   Documentation/admin-guide/pm/intel_pstate.rst:611:
>>     ERROR: Indirect hyperlink target (id="id15") refers to target
>>     "global attributes", which is a duplicate, and cannot be used as
>>     a unique reference.
>>   ERROR: Duplicate target name, cannot be used as a unique reference:
>>   "passive mode", "active mode", "global attributes".
> 
> Hmm... I don't see these warnings when I build htmldocs by:
> 
>   $ make SPHINXOPTS='-j 1' htmldocs
> 
> My environment uses docutils 0.21.2 and Sphinx 8.2.3, though. What are yours?


I do see the warnings and this patch fixes them in my testing.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

docutils-3.13 (Docutils 0.22.2, Python 3.13.9, on linux)
sphinx-build 8.2.3

>> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
>> index 26e702c7016e..9cdd9dad6516 100644
>> --- a/Documentation/admin-guide/pm/intel_pstate.rst
>> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
>> @@ -62,6 +62,8 @@ a certain performance scaling algorithm.  Which of them will be in effect
>>  depends on what kernel command line options are used and on the capabilities of
>>  the processor.
>>
>> +.. _Active Mode:
>> +
>>  Active Mode
>>  -----------
>>
>> @@ -94,6 +96,8 @@ Which of the P-state selection algorithms is used by default depends on the
>>  Namely, if that option is set, the ``performance`` algorithm will be used by
>>  default, and the other one will be used by default if it is not set.
>>
>> +.. _Active Mode With HWP:
>> +
>>  Active Mode With HWP
>>  ~~~~~~~~~~~~~~~~~~~~
>>
>> @@ -192,6 +196,8 @@ This is the default P-state selection algorithm if the
>>  :c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option
>>  is not set.
>>
>> +.. _Passive Mode:
>> +
>>  Passive Mode
>>  ------------
>>
>> @@ -432,6 +438,8 @@ the ``energy_model`` directory in ``debugfs`` (typlically mounted on
>>  User Space Interface in ``sysfs``
>>  =================================
>>
>> +.. _Global Attributes:
>> +
>>  Global Attributes
>>  -----------------
>>
>>
> 
> The diff LGTM, nevertheless.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Thanks.
> 



-- 
~Randy

