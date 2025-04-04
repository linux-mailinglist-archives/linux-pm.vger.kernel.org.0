Return-Path: <linux-pm+bounces-24794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382BA7B77B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 07:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EC3189CE1A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D816F8E5;
	Fri,  4 Apr 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="HkWrS4lG"
X-Original-To: linux-pm@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E115DBB3;
	Fri,  4 Apr 2025 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745814; cv=none; b=ArkQU6aaMUe+gspkkM2v/amYKZYaSvzi1TFQCf3qXqMwe2E8G5uy85xri7vsPM3oQwGgQYezlm/WvBVuwy5kbeHyqZN3+E3WcHGyYgSV0BVLc129yWsiLb1uwvLJQ1sRrLWDULoYGWO1lfWCyZLhXp1OYUrGhAb20LQdeuiIbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745814; c=relaxed/simple;
	bh=E0lTe+FJPV0F1VKQxQbHoHGJojoKObYVSGdv5v9cqxw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=uoZv9tJ473RHyrpmoprUAvwAjiTEdPiyWqJEWf3CNzj5nDENUNKYwiNhtXUIklI6YbnhqQk8IiXFfqDPZ6X84bhCteB+emACIgKyeKTaPSA2fGD2wv6tlgnloA9AzWh70uPinRs1OpqGQdue6uQGmr/jnpU3d+o9pxrQ/2lZA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=HkWrS4lG; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Content-Type: multipart/mixed; boundary="------------08L6YdHquZUpv03HEHpbPDhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743745810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ytiwc9QXzR9VaVB1US+GOGp83Z98Cx/zqNhgfzVo6k=;
	b=HkWrS4lG4mKe4eli15RrfKo6WsOqx2JmVjBov6gUuHXf8P0/0dCu5wzDoMpKWSdaJkQJqP
	TQApk0DgsMM5F5ZTl6tEN0lxx9g/Z4TYTPawLFlDNv5KNidgOR9CTNzr7hI9+wsj/38vi0
	/aQj0iYD4KKdP6VoR7xsZJk12F4sWv90H+HmA3WLohwOBqoJfsQwzPJXJiJTbY1A79Ifuw
	OA0+unqYbrODdbLBy1o7cwk+nUwvctiBsAXi6sV+4FXaKyJVyw1olTBsYWakIY5EAT9Q3Q
	6BSjTAGnOKXd51gCSFMzKCXgoLeuYrTZ3ZNSQ9V19vtJlS0LpK4skaU4gY4j/w==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=msizanoen@qtmlabs.xyz
Message-ID: <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
Date: Fri, 4 Apr 2025 12:50:03 +0700
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
 <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
Content-Language: en-US
In-Reply-To: <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
X-Spamd-Bar: +
X-Spam-Level: *

This is a multi-part message in MIME format.
--------------08L6YdHquZUpv03HEHpbPDhB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Here's an updated version of the patch that better handles pathological 
e820 tables.

On 4/4/25 11:56, msizanoen wrote:
> Also, can you reproduce this issue with a target kernel (the kernel 
> being kexec-ed) that has one of the patches attached (select the 
> correct one according to your kernel version) applied, with either 
> kexec_load or kexec_file_load?
>
> On 4/4/25 09:54, msizanoen wrote:
>> Can you send the dmesg logs for this case (6.13 + mentioned patch 
>> series backported as target kernel, using kexec_load)?
>>
>> On 4/4/25 05:00, Roberto Ricci wrote:
>>> On 2025-04-01 19:59 +0700, msizanoen wrote:
>>>> [snip]
>>>> It seems like `e820__register_nosave_regions` is erroneously 
>>>> marking some
>>>> kernel memory as nosave in the presence of sub-page e820 regions. 
>>>> In theory
>>>> backporting
>>>> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ 
>>>> should
>>>> be sufficient to avoid this but a fix for the actual root cause is
>>>> preferred.
>>> When using kexec_file_load, this patch series fixes the issue not only
>>> in theory but also in practice.
>>> But the issue with kexec_load (see
>>> https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
>>> ), which might be related, is not fixed.
--------------08L6YdHquZUpv03HEHpbPDhB
Content-Type: text/x-patch; charset=UTF-8; name="for-6.14-and-earlier-v2.diff"
Content-Disposition: attachment; filename="for-6.14-and-earlier-v2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
ZTgyMC5jCmluZGV4IDQ4OTNkMzBjZTQzOC4uNWQ5NjNkZjYzYjdhIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvZTgyMC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKQEAg
LTc1NCwyMiArNzU0LDIxIEBAIHZvaWQgX19pbml0IGU4MjBfX21lbW9yeV9zZXR1cF9leHRl
bmRlZCh1NjQgcGh5c19hZGRyLCB1MzIgZGF0YV9sZW4pCiB2b2lkIF9faW5pdCBlODIwX19y
ZWdpc3Rlcl9ub3NhdmVfcmVnaW9ucyh1bnNpZ25lZCBsb25nIGxpbWl0X3BmbikKIHsKIAlp
bnQgaTsKLQl1bnNpZ25lZCBsb25nIHBmbiA9IDA7CisJdTY0IGxhc3RfYWRkciA9IDA7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgZTgyMF90YWJsZS0+bnJfZW50cmllczsgaSsrKSB7CiAJCXN0
cnVjdCBlODIwX2VudHJ5ICplbnRyeSA9ICZlODIwX3RhYmxlLT5lbnRyaWVzW2ldOwogCi0J
CWlmIChwZm4gPCBQRk5fVVAoZW50cnktPmFkZHIpKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3Jl
Z2lvbihwZm4sIFBGTl9VUChlbnRyeS0+YWRkcikpOwotCi0JCXBmbiA9IFBGTl9ET1dOKGVu
dHJ5LT5hZGRyICsgZW50cnktPnNpemUpOwotCiAJCWlmIChlbnRyeS0+dHlwZSAhPSBFODIw
X1RZUEVfUkFNICYmIGVudHJ5LT50eXBlICE9IEU4MjBfVFlQRV9SRVNFUlZFRF9LRVJOKQot
CQkJcmVnaXN0ZXJfbm9zYXZlX3JlZ2lvbihQRk5fVVAoZW50cnktPmFkZHIpLCBwZm4pOwor
CQkJY29udGludWU7CiAKLQkJaWYgKHBmbiA+PSBsaW1pdF9wZm4pCi0JCQlicmVhazsKKwkJ
aWYgKGxhc3RfYWRkciA8IGVudHJ5LT5hZGRyKQorCQkJcmVnaXN0ZXJfbm9zYXZlX3JlZ2lv
bihQRk5fVVAobGFzdF9hZGRyKSwgUEZOX0RPV04oZW50cnktPmFkZHIpKTsKKworCQlsYXN0
X2FkZHIgPSBlbnRyeS0+YWRkciArIGVudHJ5LT5zaXplOwogCX0KKworCXJlZ2lzdGVyX25v
c2F2ZV9yZWdpb24oUEZOX1VQKGxhc3RfYWRkciksIGxpbWl0X3Bmbik7CiB9CiAKICNpZmRl
ZiBDT05GSUdfQUNQSQo=
--------------08L6YdHquZUpv03HEHpbPDhB
Content-Type: text/x-patch; charset=UTF-8; name="for-master-v2.diff"
Content-Disposition: attachment; filename="for-master-v2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
ZTgyMC5jCmluZGV4IDU3MTIwZjA3NDljYy4uNjU2ZWQ3YWJkMjhkIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvZTgyMC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKQEAg
LTc1MywyMiArNzUzLDIxIEBAIHZvaWQgX19pbml0IGU4MjBfX21lbW9yeV9zZXR1cF9leHRl
bmRlZCh1NjQgcGh5c19hZGRyLCB1MzIgZGF0YV9sZW4pCiB2b2lkIF9faW5pdCBlODIwX19y
ZWdpc3Rlcl9ub3NhdmVfcmVnaW9ucyh1bnNpZ25lZCBsb25nIGxpbWl0X3BmbikKIHsKIAlp
bnQgaTsKLQl1bnNpZ25lZCBsb25nIHBmbiA9IDA7CisJdTY0IGxhc3RfYWRkciA9IDA7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgZTgyMF90YWJsZS0+bnJfZW50cmllczsgaSsrKSB7CiAJCXN0
cnVjdCBlODIwX2VudHJ5ICplbnRyeSA9ICZlODIwX3RhYmxlLT5lbnRyaWVzW2ldOwogCi0J
CWlmIChwZm4gPCBQRk5fVVAoZW50cnktPmFkZHIpKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3Jl
Z2lvbihwZm4sIFBGTl9VUChlbnRyeS0+YWRkcikpOwotCi0JCXBmbiA9IFBGTl9ET1dOKGVu
dHJ5LT5hZGRyICsgZW50cnktPnNpemUpOwotCiAJCWlmIChlbnRyeS0+dHlwZSAhPSBFODIw
X1RZUEVfUkFNKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3JlZ2lvbihQRk5fVVAoZW50cnktPmFk
ZHIpLCBwZm4pOworCQkJY29udGludWU7CiAKLQkJaWYgKHBmbiA+PSBsaW1pdF9wZm4pCi0J
CQlicmVhazsKKwkJaWYgKGxhc3RfYWRkciA8IGVudHJ5LT5hZGRyKQorCQkJcmVnaXN0ZXJf
bm9zYXZlX3JlZ2lvbihQRk5fVVAobGFzdF9hZGRyKSwgUEZOX0RPV04oZW50cnktPmFkZHIp
KTsKKworCQlsYXN0X2FkZHIgPSBlbnRyeS0+YWRkciArIGVudHJ5LT5zaXplOwogCX0KKwor
CXJlZ2lzdGVyX25vc2F2ZV9yZWdpb24oUEZOX1VQKGxhc3RfYWRkciksIGxpbWl0X3Bmbik7
CiB9CiAKICNpZmRlZiBDT05GSUdfQUNQSQo=

--------------08L6YdHquZUpv03HEHpbPDhB--

