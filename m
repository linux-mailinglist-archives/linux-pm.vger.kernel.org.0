Return-Path: <linux-pm+bounces-42692-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LsLMw36kmlx0gEAu9opvQ
	(envelope-from <linux-pm+bounces-42692-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 12:05:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB3142A74
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA883003E99
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2E2C028C;
	Mon, 16 Feb 2026 11:05:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C52690C0;
	Mon, 16 Feb 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239946; cv=none; b=jbfBUi9XD+z7vhEL3mkiRYEXulS8DvUdIBi2sBtSEzmU435PZEDWmsEg2U254h85NnIVCzNOecKJ0gmqY28vEefyIpCIOmdGHkL0+0sDIuR1ttxM7KcnE7xAD55S6w6Z9FjFtbq92qxaSg3UQZMcR1KIGPqSaqZ6G7oJki4r+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239946; c=relaxed/simple;
	bh=GwrN906MkGiIaKqfGH4X5luZEMbp/rIxAu7QH5EMOO4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=J4F2mfnQSzw3lo1KWKYvOBy8b290y8S+0L4KBWBPJf868BELq4CtqAPdFDO42EhdCdkToVx+svenLEuY1odsxFX/g7EfYKHKYDcwAWYymuDT7ZP9VR/UYKZl/V52xwS6g6hlcQBHajwU+uP2OUWVnV35NvEgeDX4Q0aUftyIIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D9A3150C;
	Mon, 16 Feb 2026 03:05:37 -0800 (PST)
Received: from [10.1.34.88] (e127648.arm.com [10.1.34.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 446E53F632;
	Mon, 16 Feb 2026 03:05:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------CZqWEMrI60OMuZ3y1ooRMeZl"
Message-ID: <398c6f07-d964-4dc0-9fa6-bf7d89442da1@arm.com>
Date: Mon, 16 Feb 2026 11:05:41 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: ladder: Fix state index when only one idle state
 is registered
From: Christian Loehle <christian.loehle@arm.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260211053552.739337-1-aboorvad@linux.ibm.com>
 <c3d670cd-fc54-49a8-b640-fb16f9bd0487@arm.com>
 <7297173684f500e006a2997b92c927262221336f.camel@linux.ibm.com>
 <aa4e56dc-d74b-44dc-b628-c7573159de99@arm.com>
Content-Language: en-US
In-Reply-To: <aa4e56dc-d74b-44dc-b628-c7573159de99@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42692-lists,linux-pm=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 21AB3142A74
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------CZqWEMrI60OMuZ3y1ooRMeZl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/26 13:44, Christian Loehle wrote:
> On 2/13/26 08:29, Aboorva Devarajan wrote:
>> On Wed, 2026-02-11 at 15:00 +0000, Christian Loehle wrote:
>>> On 2/11/26 05:35, Aboorva Devarajan wrote:
>>>> On certain platforms (PowerNV systems without a power-mgt DT node),
>>>> cpuidle may register only a single idle state. In cases where that
>>>> single state is a polling state (state 0), the ladder governor may
>>>> incorrectly treat state 1 as the first usable state and pass an
>>>> out-of-bounds index. This can lead to a NULL enter callback being
>>>> invoked, ultimately resulting in a system crash.
>>>>
>>>> [   13.342636] cpuidle-powernv : Only Snooze is available
>>>> [   13.351854] Faulting instruction address: 0x00000000
>>>> [   13.376489] NIP [0000000000000000] 0x0
>>>> [   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668
>>>>
>>>> Fix this by determining the first non-polling state index based on
>>>> the number of registered states, and by returning state 0 when only
>>>> one state is registered.
>>>>
>>>> Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
>>>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>
>>> Agreed that the current behavior is a bug, but is there really much value
>>> in using a cpuidle governor with just a polling state?
>>> It's dead code and trivial to bail out of in cpuidle, right?
>>>
>>
>> Hi Christian,
>>
>> Thanks for the review.
>>
>> Other governors (teo, menu) already handle this single-state scenario
>> correctly. Fixing ladder's first_idx calculation seemed like the most
>> targeted fix, however since ladder is not widely used this is likely
>> to go unnoticed, it only popped up during testing with a missing
>> power-mgt device tree node.
>>
>> yes, adding a bail-out in the core cpuidle_select() is also trivial and
>> would benefit all governors uniformly. Setting stop_tick to false keeps
>> the tick running, which is correct for a single state configuration.
>>
>> Please let me know if you'd prefer this approach instead.
>>
>> ---
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index c7876e9e024f..ea082419f7db 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct
>> cpuidle_device *dev,
>>  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device
>> *dev,
>>                    bool *stop_tick)
>>  {
>> +       /*
>> +        * If there is only a single idle state (or none), there is
>> nothing
>> +        * meaningful for the governor to choose. Skip the governor and
>> +        * always use state 0 with the tick running.
>> +        */
>> +       if (unlikely(drv->state_count <= 1)) {
> 
> I think the unlikely isn't helping here, this just let the branch predictor
> handle this as it won't change anyway.
> 
>> +               *stop_tick = false;
>> +               return 0;
>> +       }
>> +
>>         return cpuidle_curr_governor->select(drv, dev, stop_tick);
>>  }
>>
> 
> I prefer this, additionally of course:

I've attached them as patches with a sign-off, feel free to pick them up as a series
or if you provide your signoff I can do that as well.

--------------CZqWEMrI60OMuZ3y1ooRMeZl
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-cpuidle-teo-Remove-single-state-handling.patch"
Content-Disposition: attachment;
 filename="0002-cpuidle-teo-Remove-single-state-handling.patch"
Content-Transfer-Encoding: base64

RnJvbSA1NmJhNmNiZWM5YWNhNjQ1YTUxNzQ0MjYxZWNmMDI3NjA3MmUwMDFkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9l
aGxlQGFybS5jb20+CkRhdGU6IE1vbiwgMTYgRmViIDIwMjYgMTE6MDI6NTUgKzAwMDAKU3Vi
amVjdDogW1BBVENIIDIvMl0gY3B1aWRsZTogdGVvOiBSZW1vdmUgc2luZ2xlIHN0YXRlIGhh
bmRsaW5nCgpjcHVpZGxlIHN5c3RlbXMgd2hlcmUgdGhlIGdvdmVybm9yIGhhcyBubyBjaG9p
Y2UgYmVjYXVzZSB0aGVyZSdzIG9ubHkKYSBzaW5nbGUgaWRsZSBzdGF0ZSBhcmUgbm93IGhh
bmRsZWQgYnkgY3B1aWRsZSBjb3JlIGFuZCBieXBhc3MgdGhlCmdvdmVybm9yLCBzbyByZW1v
dmUgdGhlIHJlbGF0ZWQgaGFuZGxpbmcuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTG9l
aGxlIDxjaHJpc3RpYW4ubG9laGxlQGFybS5jb20+Ci0tLQogZHJpdmVycy9jcHVpZGxlL2dv
dmVybm9ycy90ZW8uYyB8IDYgLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL3Rlby5jIGIvZHJp
dmVycy9jcHVpZGxlL2dvdmVybm9ycy90ZW8uYwppbmRleCA4MWFjNWZkNThhMWMuLjliNWI4
YzYxNzgwNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jcHVpZGxlL2dvdmVybm9ycy90ZW8uYwor
KysgYi9kcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL3Rlby5jCkBAIC0zMTcsMTIgKzMxNyw2
IEBAIHN0YXRpYyBpbnQgdGVvX3NlbGVjdChzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwg
c3RydWN0IGNwdWlkbGVfZGV2aWNlICpkZXYsCiAJICovCiAJY3B1X2RhdGEtPnNsZWVwX2xl
bmd0aF9ucyA9IEtUSU1FX01BWDsKIAotCS8qIENoZWNrIGlmIHRoZXJlIGlzIGFueSBjaG9p
Y2UgaW4gdGhlIGZpcnN0IHBsYWNlLiAqLwotCWlmIChkcnYtPnN0YXRlX2NvdW50IDwgMikg
ewotCQlpZHggPSAwOwotCQlnb3RvIG91dF90aWNrOwotCX0KLQogCWlmICghZGV2LT5zdGF0
ZXNfdXNhZ2VbMF0uZGlzYWJsZSkKIAkJaWR4ID0gMDsKIAotLSAKMi4zNC4xCgo=
--------------CZqWEMrI60OMuZ3y1ooRMeZl
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-cpuidle-menu-Remove-single-state-handling.patch"
Content-Disposition: attachment;
 filename="0001-cpuidle-menu-Remove-single-state-handling.patch"
Content-Transfer-Encoding: base64

RnJvbSAxMDQ2YmFjNjE4YzA1MjYyZDEzOTA3MWU1NWY0MjQ4ZDMxMjEzMTBkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9l
aGxlQGFybS5jb20+CkRhdGU6IE1vbiwgMTYgRmViIDIwMjYgMTE6MDE6MDIgKzAwMDAKU3Vi
amVjdDogW1BBVENIIDEvMl0gY3B1aWRsZTogbWVudTogUmVtb3ZlIHNpbmdsZSBzdGF0ZSBo
YW5kbGluZwoKY3B1aWRsZSBzeXN0ZW1zIHdoZXJlIHRoZSBnb3Zlcm5vciBoYXMgbm8gY2hv
aWNlIGJlY2F1c2UgdGhlcmUncyBvbmx5CmEgc2luZ2xlIGlkbGUgc3RhdGUgYXJlIG5vdyBo
YW5kbGVkIGJ5IGNwdWlkbGUgY29yZSBhbmQgYnlwYXNzIHRoZQpnb3Zlcm5vciwgc28gcmVt
b3ZlIHRoZSByZWxhdGVkIGhhbmRsaW5nLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIExv
ZWhsZSA8Y2hyaXN0aWFuLmxvZWhsZUBhcm0uY29tPgotLS0KIGRyaXZlcnMvY3B1aWRsZS9n
b3Zlcm5vcnMvbWVudS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVpZGxlL2dvdmVybm9y
cy9tZW51LmMgYi9kcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL21lbnUuYwppbmRleCA2NGQ2
ZjdhMWM3NzYuLmZkZmE1ZDdlMTBhNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jcHVpZGxlL2dv
dmVybm9ycy9tZW51LmMKKysrIGIvZHJpdmVycy9jcHVpZGxlL2dvdmVybm9ycy9tZW51LmMK
QEAgLTI3MSw3ICsyNzEsNyBAQCBzdGF0aWMgaW50IG1lbnVfc2VsZWN0KHN0cnVjdCBjcHVp
ZGxlX2RyaXZlciAqZHJ2LCBzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwKIAkJZGF0YS0+
YnVja2V0ID0gQlVDS0VUUyAtIDE7CiAJfQogCi0JaWYgKHVubGlrZWx5KGRydi0+c3RhdGVf
Y291bnQgPD0gMSB8fCBsYXRlbmN5X3JlcSA9PSAwKSB8fAorCWlmICh1bmxpa2VseShsYXRl
bmN5X3JlcSA9PSAwKSB8fAogCSAgICAoKGRhdGEtPm5leHRfdGltZXJfbnMgPCBkcnYtPnN0
YXRlc1sxXS50YXJnZXRfcmVzaWRlbmN5X25zIHx8CiAJICAgICAgbGF0ZW5jeV9yZXEgPCBk
cnYtPnN0YXRlc1sxXS5leGl0X2xhdGVuY3lfbnMpICYmCiAJICAgICAhZGV2LT5zdGF0ZXNf
dXNhZ2VbMF0uZGlzYWJsZSkpIHsKLS0gCjIuMzQuMQoK

--------------CZqWEMrI60OMuZ3y1ooRMeZl--

