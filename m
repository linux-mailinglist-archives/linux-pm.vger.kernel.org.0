Return-Path: <linux-pm+bounces-24793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955FA7B700
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 06:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63482188FAB3
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 04:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC31386B4;
	Fri,  4 Apr 2025 04:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="EvttBZce"
X-Original-To: linux-pm@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2AA95E;
	Fri,  4 Apr 2025 04:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743742593; cv=none; b=kU9nIX0hOD+m750i/n/yMdJ+RuK68s5xKlX+JpPKtbZCjKK9EFW3pTS8r+4IzhR+daGBqTqZjG4pW/kvCb8265bnm+8dtVPISoZik/pFH/PzJV2j8bOIZQXPTg6MUiJS7nuffPvlGH+aD4F6/m8ZmuoeGJzlnx6rbM4KLQmxoq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743742593; c=relaxed/simple;
	bh=nwhDu68aWdWRGWKSFWI4REESRhrTBgR1bfnknaQzRfc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=D5vIvF79nurPaTdOVkJ+ufG4aFjlTB4eQ7TwPFlouKJk9c1Hb1HGSNOauBs8Sj0gcAXcEGR/CgDWBVHCR8BM9iIoeJ8O7i+oFPNrvKjpiCBTboS2ldc4MWSzTyMR6ngGRZao04K7JSIgowYrKjYTaQyGhNHc0TrbyQDGVm304CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=EvttBZce; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Content-Type: multipart/mixed; boundary="------------QNl5qfMEuxRVraWYtdKPb7kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743742589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vau1mPOVxvBKN2mqH71v2LRxp6uq3iTaCAxzKJIn02I=;
	b=EvttBZcejpCKd38V1E4icwkGSfefBiF9OpE8mKuYddA8vEIxPuNrv2n4/uelEym54+yJtI
	sWEdYXo9743t6WTxlZjCz+F05LIa89q3kpLVxCtHkJQKwxUEs9s5Jd2jbje6G+mqUznBWW
	zw+gNKcRHsxLCaESAB2q3YSsyYwK+a7vxidWEXX1a2L7KXgqjsptfS9laevme9Z6nGS5Ft
	oempeWsiUZSVHpr7rHdfXpGpKdQSBcN9PWgUvmA8IybtVXK25xINb5sb3o6TAMwzq9pMU0
	cE5alLNMfYnXgzazSEWGG38Hn0UbUBLxW06KasCnSdjA0s45W9gfvGXkys+HCg==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=msizanoen@qtmlabs.xyz
Message-ID: <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
Date: Fri, 4 Apr 2025 11:56:21 +0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
From: msizanoen <msizanoen@qtmlabs.xyz>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
 ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 akpm@linux-foundation.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Z4WFjBVHpndct7br@desktop0a> <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
 <Z-8E-LLs1dFWfn6J@desktop0a>
 <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
Content-Language: en-US
In-Reply-To: <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
X-Spamd-Bar: +
X-Spam-Level: *

This is a multi-part message in MIME format.
--------------QNl5qfMEuxRVraWYtdKPb7kl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Also, can you reproduce this issue with a target kernel (the kernel 
being kexec-ed) that has one of the patches attached (select the correct 
one according to your kernel version) applied, with either kexec_load or 
kexec_file_load?

On 4/4/25 09:54, msizanoen wrote:
> Can you send the dmesg logs for this case (6.13 + mentioned patch 
> series backported as target kernel, using kexec_load)?
>
> On 4/4/25 05:00, Roberto Ricci wrote:
>> On 2025-04-01 19:59 +0700, msizanoen wrote:
>>> [snip]
>>> It seems like `e820__register_nosave_regions` is erroneously marking 
>>> some
>>> kernel memory as nosave in the presence of sub-page e820 regions. In 
>>> theory
>>> backporting
>>> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ 
>>> should
>>> be sufficient to avoid this but a fix for the actual root cause is
>>> preferred.
>> When using kexec_file_load, this patch series fixes the issue not only
>> in theory but also in practice.
>> But the issue with kexec_load (see
>> https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
>> ), which might be related, is not fixed.
--------------QNl5qfMEuxRVraWYtdKPb7kl
Content-Type: text/x-patch; charset=UTF-8; name="for-6.14-and-earlier.diff"
Content-Disposition: attachment; filename="for-6.14-and-earlier.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
ZTgyMC5jCmluZGV4IDgyYjk2ZWQ5ODkwYS4uZWY2ZTYzOWU0M2ZhIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvZTgyMC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKQEAg
LTc1NCwyMCArNzU0LDIwIEBAIHZvaWQgX19pbml0IGU4MjBfX21lbW9yeV9zZXR1cF9leHRl
bmRlZCh1NjQgcGh5c19hZGRyLCB1MzIgZGF0YV9sZW4pCiB2b2lkIF9faW5pdCBlODIwX19y
ZWdpc3Rlcl9ub3NhdmVfcmVnaW9ucyh1bnNpZ25lZCBsb25nIGxpbWl0X3BmbikKIHsKIAlp
bnQgaTsKLQl1bnNpZ25lZCBsb25nIHBmbiA9IDA7CisJdTY0IGxhc3RfYWRkciA9IDA7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgZTgyMF90YWJsZS0+bnJfZW50cmllczsgaSsrKSB7CiAJCXN0
cnVjdCBlODIwX2VudHJ5ICplbnRyeSA9ICZlODIwX3RhYmxlLT5lbnRyaWVzW2ldOwogCi0J
CWlmIChwZm4gPCBQRk5fVVAoZW50cnktPmFkZHIpKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3Jl
Z2lvbihwZm4sIFBGTl9VUChlbnRyeS0+YWRkcikpOworCQlpZiAobGFzdF9hZGRyIDwgZW50
cnktPmFkZHIpCisJCQlyZWdpc3Rlcl9ub3NhdmVfcmVnaW9uKFBGTl9VUChsYXN0X2FkZHIp
LCBQRk5fRE9XTihlbnRyeS0+YWRkcikpOwogCi0JCXBmbiA9IFBGTl9ET1dOKGVudHJ5LT5h
ZGRyICsgZW50cnktPnNpemUpOworCQlsYXN0X2FkZHIgPSBlbnRyeS0+YWRkciArIGVudHJ5
LT5zaXplOwogCiAJCWlmIChlbnRyeS0+dHlwZSAhPSBFODIwX1RZUEVfUkFNICYmIGVudHJ5
LT50eXBlICE9IEU4MjBfVFlQRV9SRVNFUlZFRF9LRVJOKQotCQkJcmVnaXN0ZXJfbm9zYXZl
X3JlZ2lvbihQRk5fVVAoZW50cnktPmFkZHIpLCBwZm4pOworCQkJcmVnaXN0ZXJfbm9zYXZl
X3JlZ2lvbihQRk5fVVAoZW50cnktPmFkZHIpLCBQRk5fRE9XTihsYXN0X2FkZHIpKTsKIAot
CQlpZiAocGZuID49IGxpbWl0X3BmbikKKwkJaWYgKFBGTl9ET1dOKGxhc3RfYWRkcikgPj0g
bGltaXRfcGZuKQogCQkJYnJlYWs7CiAJfQogfQo=
--------------QNl5qfMEuxRVraWYtdKPb7kl
Content-Type: text/x-patch; charset=UTF-8; name="for-master.diff"
Content-Disposition: attachment; filename="for-master.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
ZTgyMC5jCmluZGV4IDU3MTIwZjA3NDljYy4uYzMyZWY3ZjUyMDVmIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvZTgyMC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKQEAg
LTc1MywyMCArNzUzLDIwIEBAIHZvaWQgX19pbml0IGU4MjBfX21lbW9yeV9zZXR1cF9leHRl
bmRlZCh1NjQgcGh5c19hZGRyLCB1MzIgZGF0YV9sZW4pCiB2b2lkIF9faW5pdCBlODIwX19y
ZWdpc3Rlcl9ub3NhdmVfcmVnaW9ucyh1bnNpZ25lZCBsb25nIGxpbWl0X3BmbikKIHsKIAlp
bnQgaTsKLQl1bnNpZ25lZCBsb25nIHBmbiA9IDA7CisJdTY0IGxhc3RfYWRkciA9IDA7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgZTgyMF90YWJsZS0+bnJfZW50cmllczsgaSsrKSB7CiAJCXN0
cnVjdCBlODIwX2VudHJ5ICplbnRyeSA9ICZlODIwX3RhYmxlLT5lbnRyaWVzW2ldOwogCi0J
CWlmIChwZm4gPCBQRk5fVVAoZW50cnktPmFkZHIpKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3Jl
Z2lvbihwZm4sIFBGTl9VUChlbnRyeS0+YWRkcikpOworCQlpZiAobGFzdF9hZGRyIDwgZW50
cnktPmFkZHIpCisJCQlyZWdpc3Rlcl9ub3NhdmVfcmVnaW9uKFBGTl9VUChsYXN0X2FkZHIp
LCBQRk5fRE9XTihlbnRyeS0+YWRkcikpOwogCi0JCXBmbiA9IFBGTl9ET1dOKGVudHJ5LT5h
ZGRyICsgZW50cnktPnNpemUpOworCQlsYXN0X2FkZHIgPSBlbnRyeS0+YWRkciArIGVudHJ5
LT5zaXplOwogCiAJCWlmIChlbnRyeS0+dHlwZSAhPSBFODIwX1RZUEVfUkFNKQotCQkJcmVn
aXN0ZXJfbm9zYXZlX3JlZ2lvbihQRk5fVVAoZW50cnktPmFkZHIpLCBwZm4pOworCQkJcmVn
aXN0ZXJfbm9zYXZlX3JlZ2lvbihQRk5fVVAoZW50cnktPmFkZHIpLCBQRk5fRE9XTihsYXN0
X2FkZHIpKTsKIAotCQlpZiAocGZuID49IGxpbWl0X3BmbikKKwkJaWYgKFBGTl9ET1dOKGxh
c3RfYWRkcikgPj0gbGltaXRfcGZuKQogCQkJYnJlYWs7CiAJfQogfQo=

--------------QNl5qfMEuxRVraWYtdKPb7kl--

