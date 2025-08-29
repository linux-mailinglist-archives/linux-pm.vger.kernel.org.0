Return-Path: <linux-pm+bounces-33406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F1B3B8F0
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B3458261C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37373093BA;
	Fri, 29 Aug 2025 10:31:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9DD31987E
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463496; cv=none; b=XXLo6+NFl5xybRLy7GMYCJPtqvXIzcTUoUrnIgAs/Wkom6RoDZ/aMjPmp/mJ7YhtQHSQ61FECxK/cHqclShmkAVOwJl76jjOCF3QKhMp63rdladLHiQXt+tjWhho6sOqdUpiEx8rB5yY6ZsA2Aa2613hnlroy+1DLpbuM1Ijhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463496; c=relaxed/simple;
	bh=8rgYeXyGy9NA1d1irG2esa4TUpGiaKHVwzEVmjsUOUU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=UUjVhGQyhBXBIbMxSZBAByYQNKWQCPGNAVkuhGbZ6uter5XT1sraUCT5SXzAwZDe+knfhhCyde+94TdF1x7Qhvk9uX4/7TXgXp59ggZDd/xPsfCglsvOaxD1Z9bWtYb1LGCqsCuA1ZFXFv9gMRrNaQXrZd+1n/Exln61yq2hgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C521758;
	Fri, 29 Aug 2025 03:31:25 -0700 (PDT)
Received: from [10.57.92.164] (unknown [10.57.92.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D22A3F694;
	Fri, 29 Aug 2025 03:31:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------x7PfBf0npKUZ0WmM9YMUIkbi"
Message-ID: <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
Date: Fri, 29 Aug 2025 11:31:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU
 topology
To: Kenneth Crudup <kenny@panix.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
 <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>

This is a multi-part message in MIME format.
--------------x7PfBf0npKUZ0WmM9YMUIkbi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 18:42, Kenneth Crudup wrote:
> 
>> So there's probably a problem here, but presumably your proposal breaks the late boot
>> (i.e. what this code was initially supposed to support).
> 
> Please explain?
> 
> It seems to me (and I really don't know, just guessing here) that if there were remaining errors from not getting any further CPU policies that the loop would just run thru all CPUs "harmlessly".

It would miss not-online-yet CPUs and never run again (potentially).

> 
> Now perhaps to ensure the schedule_delayed_work() gets run, what about a flag that gets set if any CPU policy was accessed, and the schedule_delayed_work() gets run if it's never set?

Yeah that's the obvious immediate fix here, I've attached a patch for it. (please test!)
I wonder though, given that this works fine on my x86 nosmt hybrid (presumably something like
yours?) is this actually an issue for you?
With intel_pstate=passive (and neutering a bunch of userspace stuff that insists on switching
schedutil to something inferior) I get a working
# cat /proc/sys/kernel/sched_energy_aware 
1

with all online CPUs having an EM (see /sys/kernel/debug/energy_model/ )

> [snip]

+CC
Dietmar who has also played with this and reviewed the x86 EM part.
--------------x7PfBf0npKUZ0WmM9YMUIkbi
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-PM-EM-Fix-late-boot-with-holes-in-CPU-topology.patch"
Content-Disposition: attachment;
 filename*0="0001-PM-EM-Fix-late-boot-with-holes-in-CPU-topology.patch"
Content-Transfer-Encoding: base64

RnJvbSBlNTA4N2M4NThmZTdiZjMxNjgwYWI2MjRhM2IzZmIxYTBmMDEzZWY5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9l
aGxlQGFybS5jb20+CkRhdGU6IEZyaSwgMjkgQXVnIDIwMjUgMTA6NTg6NDMgKzAxMDAKU3Vi
amVjdDogW1BBVENIXSBQTTogRU06IEZpeCBsYXRlIGJvb3Qgd2l0aCBob2xlcyBpbiBDUFUg
dG9wb2xvZ3kKCmNvbW1pdCBlM2YxMTY0ZmM5ZWUgKCJQTTogRU06IFN1cHBvcnQgbGF0ZSBD
UFVzIGJvb3RpbmcgYW5kIGNhcGFjaXR5CmFkanVzdG1lbnQiKSBhZGRlZCBhIG1lY2hhbmlz
bSB0byBoYW5kbGUgQ1BVcyB0aGF0IGNvbWUgdXAgbGF0ZSBieQpyZXRyeWluZyB3aGVuIGFu
eSBvZiB0aGUgYGNwdWZyZXFfY3B1X2dldCgpYCBjYWxsIGZhaWxzLgoKSG93ZXZlciwgaWYg
dGhlcmUgYXJlIGhvbGVzIGluIHRoZSBDUFUgdG9wb2xvZ3kgKG9mZmxpbmUgQ1BVcywgZS5n
Lgpub3NtdCksIHRoZSBmaXJzdCBtaXNzaW5nIENQVSBjYXVzZXMgdGhlIGxvb3AgdG8gYnJl
YWssIHByZXZlbnRpbmcKc3Vic2VxdWVudCBvbmxpbmUgQ1BVcyBmcm9tIGJlaW5nIHVwZGF0
ZWQuCkluc3RlYWQgb2YgYWJvcnRpbmcgb24gdGhlIGZpcnN0IG1pc3NpbmcgQ1BVIHBvbGlj
eSwgbG9vcCB0aHJvdWdoIGFsbAphbmQgcmV0cnkgaWYgYW55IHdlcmUgbWlzc2luZy4KCkZp
eGVzOiBlM2YxMTY0ZmM5ZWUgKCJQTTogRU06IFN1cHBvcnQgbGF0ZSBDUFVzIGJvb3Rpbmcg
YW5kIGNhcGFjaXR5IGFkanVzdG1lbnQiKQpTdWdnZXN0ZWQtYnk6IEtlbm5ldGggQ3J1ZHVw
IDxrZW5uZXRoLmNydWR1cEBnbWFpbC5jb20+ClJlcG9ydGVkLWJ5OiBLZW5uZXRoIENydWR1
cCA8a2VubmV0aC5jcnVkdXBAZ21haWwuY29tPgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXBtLzQwMjEyNzk2LTczNGMtNDE0MC04YTg1LTg1NGY3MmI4MTQ0ZEBw
YW5peC5jb20vCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBMb2VobGUgPGNocmlzdGlhbi5sb2VobGVAYXJtLmNvbT4KLS0tCiBrZXJuZWwv
cG93ZXIvZW5lcmd5X21vZGVsLmMgfCAxNCArKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJu
ZWwvcG93ZXIvZW5lcmd5X21vZGVsLmMgYi9rZXJuZWwvcG93ZXIvZW5lcmd5X21vZGVsLmMK
aW5kZXggZWE3OTk1YTI1NzgwLi4yNDU0ZmZkNDU1ZDAgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9w
b3dlci9lbmVyZ3lfbW9kZWwuYworKysgYi9rZXJuZWwvcG93ZXIvZW5lcmd5X21vZGVsLmMK
QEAgLTc3OCw3ICs3NzgsNyBAQCB2b2lkIGVtX2FkanVzdF9jcHVfY2FwYWNpdHkodW5zaWdu
ZWQgaW50IGNwdSkKIHN0YXRpYyB2b2lkIGVtX2NoZWNrX2NhcGFjaXR5X3VwZGF0ZSh2b2lk
KQogewogCWNwdW1hc2tfdmFyX3QgY3B1X2RvbmVfbWFzazsKLQlpbnQgY3B1OworCWludCBj
cHUsIGZhaWxlZF9jcHUgPSAtMTsKIAogCWlmICghemFsbG9jX2NwdW1hc2tfdmFyKCZjcHVf
ZG9uZV9tYXNrLCBHRlBfS0VSTkVMKSkgewogCQlwcl93YXJuKCJubyBmcmVlIG1lbW9yeVxu
Iik7CkBAIC03OTYsMTAgKzc5Niw4IEBAIHN0YXRpYyB2b2lkIGVtX2NoZWNrX2NhcGFjaXR5
X3VwZGF0ZSh2b2lkKQogCiAJCXBvbGljeSA9IGNwdWZyZXFfY3B1X2dldChjcHUpOwogCQlp
ZiAoIXBvbGljeSkgewotCQkJcHJfZGVidWcoIkFjY2Vzc2luZyBjcHUlZCBwb2xpY3kgZmFp
bGVkXG4iLCBjcHUpOwotCQkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZlbV91cGRhdGVfd29y
aywKLQkJCQkJICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7Ci0JCQlicmVhazsKKwkJ
CWZhaWxlZF9jcHUgPSBjcHU7CisJCQljb250aW51ZTsKIAkJfQogCQljcHVmcmVxX2NwdV9w
dXQocG9saWN5KTsKIApAQCAtODE0LDYgKzgxMiwxMiBAQCBzdGF0aWMgdm9pZCBlbV9jaGVj
a19jYXBhY2l0eV91cGRhdGUodm9pZCkKIAkJZW1fYWRqdXN0X25ld19jYXBhY2l0eShjcHUs
IGRldiwgcGQpOwogCX0KIAorCWlmIChmYWlsZWRfY3B1ID49IDApIHsKKwkJcHJfZGVidWco
IkFjY2Vzc2luZyBjcHUlZCBwb2xpY3kgZmFpbGVkXG4iLCBmYWlsZWRfY3B1KTsKKwkJc2No
ZWR1bGVfZGVsYXllZF93b3JrKCZlbV91cGRhdGVfd29yaywKKwkJCQkgICAgICBtc2Vjc190
b19qaWZmaWVzKDEwMDApKTsKKwl9CisKIAlmcmVlX2NwdW1hc2tfdmFyKGNwdV9kb25lX21h
c2spOwogfQogCi0tIAoyLjM0LjEKCg==

--------------x7PfBf0npKUZ0WmM9YMUIkbi--

