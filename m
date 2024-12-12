Return-Path: <linux-pm+bounces-19161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EAD9EFFE0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 00:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C80168892
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6661D7E5F;
	Thu, 12 Dec 2024 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="qKfJ0itf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CD1D63E0
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045208; cv=none; b=EW5gxULuwyyHoSxxzMhZynRTVZeVrq3EjM/CsKUi2D7+0QjYvI79ipHIJVUI3bCt8jdKdPbP+y7wyvC5NjQFwG9k+nSiYo+QW3+QqevAxckiCAbI1gu9rMNHEohCzTTohKWNg0yijzqkSgQMnZ1NIU8GtblpeDZF6biX9i+N1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045208; c=relaxed/simple;
	bh=CR7dm9haeKhUzO2w0LBcl8pw69+HdwUAX6th3V2nqQw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FMw0eifHpuXeFs0/Z+W/CS1GPUxnhELMw8zAEdCd/hkLuOpljpo32ssdMxvttLySk/dXsTDvOQQJkSQjiKdLNwwhParMsEmQCm1CUjSZtB1mY9L6kJJA0RvxJ9jC8N1Z9qSdcxJ4Gr2dRPzl7ryWTYQuZrwnNFZdWz2gagrbFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=qKfJ0itf; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Y8Sv81jMkz4kgN;
	Thu, 12 Dec 2024 18:13:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734045205; bh=CR7dm9haeKhUzO2w0LBcl8pw69+HdwUAX6th3V2nqQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qKfJ0itfinIDK3UO/0asfz9gn252Qe8i3S7q9OXVmCQ9eIJr6mCOiodwQrC+MTo0w
	 Hia+6Rk0lAZZ1DSsBwmaUS79tA98L0Syib3mC+BxXaovaiOiECdkt8Z7GE0ERciffd
	 EULDtOOAp3zEYZex48vsgh+RsqFAxUyyPdIZp9AQ=
Content-Type: multipart/mixed; boundary="------------FPjnJnb9m0lJwSNN9jesde4K"
Message-ID: <7f0cfff6-fdac-4402-8978-50ea8c0752c6@panix.com>
Date: Thu, 12 Dec 2024 15:13:23 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, vidyas@nvidia.com,
 bhelgaas@google.com, andrea.righi@canonical.com, vicamo.yang@canonical.com,
 linux-pm@vger.kernel.org
References: <20241212205612.GA3368300@bhelgaas>
 <402b2e32-3b54-4e80-92fd-9237549ffa14@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <402b2e32-3b54-4e80-92fd-9237549ffa14@panix.com>

This is a multi-part message in MIME format.
--------------FPjnJnb9m0lJwSNN9jesde4K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Attached are all three patches I use (against 6.13-rc2, et al.). I've 
included "UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead" 
but I'm thinking that one has been superceded in Linus' master.

On 12/12/24 15:04, Kenneth Crudup wrote:
> 
> 
> On 12/12/24 12:56, Bjorn Helgaas wrote:
>> On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
>>>
>>> So we're on 6.13-rc2 and the patches are getting closer and closer, 
>>> but they
>>> still need to be manually added.
>>>
>>> The good news is now only (variants of) "PCI/ASPM: Enable LTR for 
>>> endpoints
>>> behind VMD" and "PCI/ASPM: Enable ASPM for links under VMD domain" are
>>> needed.
>>
>> Do you have lore links for these handy?  I'm not sure exactly what to
>> look at.
>>
>> https://lore.kernel.org/linux-pci/? 
>> q=s%3A%22Enable+LTR+for+endpoints+behind+VMD%22
>> didn't find anything.
>>
>> https://lore.kernel.org/linux-pci/? 
>> q=s%3A%22Enable+ASPM+for+links+under+VMD+domain%22
>> found
>> https://lore.kernel.org/linux-pci/20200821123222.32093-1- 
>> kai.heng.feng@canonical.com/t/#u,
>> but it's four years old.
>>
> 
> ----
> On Mon, 6 Nov 2023, Bjorn Helgaas wrote:
> 
>  > > I'd bisected it to the following commits (in this order):
>  > > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/ 
> resume
>  > > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register 
> programming
>  > > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under 
> VMD domain
>  > > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints 
> behind VMD
>  > > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name 
> instead
> 
>  > Thanks for these.  You don't happen to have URLs for those Ubuntu
>  > commits, do you?
> 
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
> lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c
> 878b5526
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
> lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297a
> ebbb8679
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
> lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4e
> db550981
> ----
> 
> -Kenny
> 
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

--------------FPjnJnb9m0lJwSNN9jesde4K
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-UBUNTU-SAUCE-PCI-ASPM-Enable-ASPM-for-links-under-VM.patch"
Content-Disposition: attachment;
 filename*0="0001-UBUNTU-SAUCE-PCI-ASPM-Enable-ASPM-for-links-under-VM.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5OWU1YWE2YzQ5M2E1YWYxZjc4ZmFiOWFlNWU5MDY3M2JjNWE1YmY0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNh
bm9uaWNhbC5jb20+CkRhdGU6IE1vbiwgMTEgQXByIDIwMjIgMTc6MjQ6MzIgKzA4MDAKU3Vi
amVjdDogW1BBVENIXSBVQlVOVFU6IFNBVUNFOiBQQ0kvQVNQTTogRW5hYmxlIEFTUE0gZm9y
IGxpbmtzIHVuZGVyIFZNRAogZG9tYWluCgpCdWdMaW5rOiBodHRwczovL2J1Z3MubGF1bmNo
cGFkLm5ldC9idWdzLzE5NDIxNjAKCk5ldyBJbnRlbCBsYXB0b3BzIHdpdGggVk1EIGNhbm5v
dCByZWFjaCBkZWVwZXIgcG93ZXIgc2F2aW5nIHN0YXRlLApyZW5kZXJzIHZlcnkgc2hvcnQg
YmF0dGVyeSB0aW1lLgoKQXMgQklPUyBtYXkgbm90IGJlIGFibGUgdG8gcHJvZ3JhbSB0aGUg
Y29uZmlnIHNwYWNlIGZvciBkZXZpY2VzIHVuZGVyClZNRCBkb21haW4sIEFTUE0gbmVlZHMg
dG8gYmUgcHJvZ3JhbW1lZCBtYW51YWxseSBieSBzb2Z0d2FyZS4gVGhpcyBpcwphbHNvIHRo
ZSBjYXNlIHVuZGVyIFdpbmRvd3MuCgpUaGUgVk1EIGNvbnRyb2xsZXIgaXRzZWxmIGlzIGEg
cm9vdCBjb21wbGV4IGludGVncmF0ZWQgZW5kcG9pbnQgdGhhdApkb2Vzbid0IGhhdmUgQVNQ
TSBjYXBhYmlsaXR5LCBzbyB3ZSBjYW4ndCBwcm9wYWdhdGUgdGhlIEFTUE0gc2V0dGluZ3Mg
dG8KZGV2aWNlcyB1bmRlciBpdC4gSGVuY2UsIHNpbXBseSBhcHBseSBBU1BNX1NUQVRFX0FM
TCB0byB0aGUgbGlua3MgdW5kZXIKVk1EIGRvbWFpbiwgdW5zdXBwb3J0ZWQgc3RhdGVzIHdp
bGwgYmUgY2xlYXJlZCBvdXQgYW55d2F5LgoKU2lnbmVkLW9mZi1ieTogS2FpLUhlbmcgRmVu
ZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWEg
UmlnaGkgPGFuZHJlYS5yaWdoaUBjYW5vbmljYWwuY29tPgooY2hlcnJ5IHBpY2tlZCBmcm9t
IGNvbW1pdCAxYTAxMDJhMDhmMjA2MTQ5ZDlhYmQ1NmMyYjI4ODc3Yzg3OGI1NTI2KQotLS0K
IGRyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIHwgIDMgKystCiBkcml2ZXJzL3BjaS9xdWlya3Mu
YyAgICB8IDExICsrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICB8ICAyICsr
CiAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYyBiL2RyaXZlcnMvcGNpL3BjaWUv
YXNwbS5jCmluZGV4IGNlZTIzNjVlNTRiOC4uZWE5NmFkMDU5ODE0IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3BjaS9wY2llL2FzcG0uYworKysgYi9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYwpA
QCAtODMwLDcgKzgzMCw4IEBAIHN0YXRpYyB2b2lkIHBjaWVfYXNwbV9jYXBfaW5pdChzdHJ1
Y3QgcGNpZV9saW5rX3N0YXRlICpsaW5rLCBpbnQgYmxhY2tsaXN0KQogCWFzcG1fbDFzc19p
bml0KGxpbmspOwogCiAJLyogU2F2ZSBkZWZhdWx0IHN0YXRlICovCi0JbGluay0+YXNwbV9k
ZWZhdWx0ID0gbGluay0+YXNwbV9lbmFibGVkOworCWxpbmstPmFzcG1fZGVmYXVsdCA9IHBh
cmVudC0+ZGV2X2ZsYWdzICYgUENJX0RFVl9GTEFHU19FTkFCTEVfQVNQTSA/CisJCQkgICAg
IFBDSUVfTElOS19TVEFURV9BU1BNX0FMTCA6IGxpbmstPmFzcG1fZW5hYmxlZDsKIAogCS8q
IFNldHVwIGluaXRpYWwgY2FwYWJsZSBzdGF0ZS4gV2lsbCBiZSB1cGRhdGVkIGxhdGVyICov
CiAJbGluay0+YXNwbV9jYXBhYmxlID0gbGluay0+YXNwbV9zdXBwb3J0OwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCBh
MmNlNGUwOGVkZjUuLjVjOWYwYmQ3MTU1OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVp
cmtzLmMKKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKQEAgLTYyNzcsMyArNjI3NywxNCBA
QCBzdGF0aWMgdm9pZCBwY2lfbWFza19yZXBsYXlfdGltZXJfdGltZW91dChzdHJ1Y3QgcGNp
X2RldiAqcGRldikKIERFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfR0xJ
LCAweDk3NTAsIHBjaV9tYXNrX3JlcGxheV90aW1lcl90aW1lb3V0KTsKIERFQ0xBUkVfUENJ
X0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfR0xJLCAweDk3NTUsIHBjaV9tYXNrX3JlcGxh
eV90aW1lcl90aW1lb3V0KTsKICNlbmRpZgorLyoKKyAqIERldmljZSBbODA4Njo5YTA5XQor
ICogQklPUyBtYXkgbm90IGJlIGFibGUgdG8gYWNjZXNzIGNvbmZpZyBzcGFjZSBvZiBkZXZp
Y2VzIHVuZGVyIFZNRCBkb21haW4sIHNvCisgKiBpdCByZWxpZXMgb24gc29mdHdhcmUgdG8g
ZW5hYmxlIEFTUE0gZm9yIGxpbmtzIHVuZGVyIFZNRC4KKyAqLworc3RhdGljIHZvaWQgcGNp
X2ZpeHVwX2VuYWJsZV9hc3BtKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworCXBkZXYtPmRl
dl9mbGFncyB8PSBQQ0lfREVWX0ZMQUdTX0VOQUJMRV9BU1BNOworfQorREVDTEFSRV9QQ0lf
RklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4OWEwOSwgcGNpX2ZpeHVwX2Vu
YWJsZV9hc3BtKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lO
VEVMLCAweGEwYjAsIHBjaV9maXh1cF9lbmFibGVfYXNwbSk7CmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaAppbmRleCA0Y2Y4OWE0YjRj
YmMuLmE4ODUxYjNlZDY3OSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9wY2kuaAorKysg
Yi9pbmNsdWRlL2xpbnV4L3BjaS5oCkBAIC0yNDUsNiArMjQ1LDggQEAgZW51bSBwY2lfZGV2
X2ZsYWdzIHsKIAlQQ0lfREVWX0ZMQUdTX05PX1JFTEFYRURfT1JERVJJTkcgPSAoX19mb3Jj
ZSBwY2lfZGV2X2ZsYWdzX3QpICgxIDw8IDExKSwKIAkvKiBEZXZpY2UgZG9lcyBob25vciBN
U0kgbWFza2luZyBkZXNwaXRlIHNheWluZyBvdGhlcndpc2UgKi8KIAlQQ0lfREVWX0ZMQUdT
X0hBU19NU0lfTUFTS0lORyA9IChfX2ZvcmNlIHBjaV9kZXZfZmxhZ3NfdCkgKDEgPDwgMTIp
LAorCS8qIEVuYWJsZSBBU1BNIHJlZ2FyZGxlc3Mgb2YgaG93IExua0N0bCBpcyBwcm9ncmFt
bWVkICovCisJUENJX0RFVl9GTEFHU19FTkFCTEVfQVNQTSA9IChfX2ZvcmNlIHBjaV9kZXZf
ZmxhZ3NfdCkgKDEgPDwgMTMpLAogfTsKIAogZW51bSBwY2lfaXJxX3Jlcm91dGVfdmFyaWFu
dCB7Ci0tIAoyLjQzLjAKCg==
--------------FPjnJnb9m0lJwSNN9jesde4K
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-UBUNTU-SAUCE-PCI-ASPM-Enable-LTR-for-endpoints-behin.patch"
Content-Disposition: attachment;
 filename*0="0001-UBUNTU-SAUCE-PCI-ASPM-Enable-LTR-for-endpoints-behin.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjY2IxYzEzMmRjMjc5NTBiMTMzODMxZTNlMjUwNmE4NzRlOWY3ZGE2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNh
bm9uaWNhbC5jb20+CkRhdGU6IE1vbiwgMTEgQXByIDIwMjIgMTc6MjQ6MzMgKzA4MDAKU3Vi
amVjdDogW1BBVENIXSBVQlVOVFU6IFNBVUNFOiBQQ0kvQVNQTTogRW5hYmxlIExUUiBmb3Ig
ZW5kcG9pbnRzIGJlaGluZCBWTUQKCkJ1Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQu
bmV0L2J1Z3MvMTk0MjE2MAoKSW4gYWRkaXRpb24gdG8gQVNQTSwgTFRSIGFsc28gbmVlZHMg
dG8gYmUgcHJvZ3JhbW1lZCB3aXRoIGEgcmVhc29uYWJsZQp2YWx1ZSB0byBsZXQgUENJZSBs
aW5rIHJlYWNoZXMgTDEuMi4KCkZvciBub3csIHByb2dyYW0gYSBoYXJkY29kZWQgdmFsdWUg
dGhhdCBpcyB1c2VkIHVuZGVyIFdpbmRvd3MuCgpXaGlsZSBhdCBpdCwgY29uc29saWRhdGUg
QVNQTSBhbmQgTFRSIGVuYWJsaW5nIGxvZ2ljIHRvIHNoYXJlIGEgc2FtZSBwY2kKZGV2aWNl
IHRhYmxlLgoKU2lnbmVkLW9mZi1ieTogS2FpLUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0Bj
YW5vbmljYWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgUmlnaGkgPGFuZHJlYS5yaWdo
aUBjYW5vbmljYWwuY29tPgooY2hlcnJ5IHBpY2tlZCBmcm9tIGNvbW1pdCA0N2M3YmZkMzE1
MTRlN2I1NGExZjgzMGY3NzA3Mjk3YWViYmI4Njc5KQotLS0KIGRyaXZlcnMvcGNpL3F1aXJr
cy5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0K
IDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMK
aW5kZXggNWM5ZjBiZDcxNTU4Li40ZjExNmVmMzJmNzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
cGNpL3F1aXJrcy5jCisrKyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCkBAIC02Mjc4LDEzICs2
Mjc4LDU1IEBAIERFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfR0xJLCAw
eDk3NTAsIHBjaV9tYXNrX3JlcGxheV90aW1lcl90aW1lb3V0CiBERUNMQVJFX1BDSV9GSVhV
UF9GSU5BTChQQ0lfVkVORE9SX0lEX0dMSSwgMHg5NzU1LCBwY2lfbWFza19yZXBsYXlfdGlt
ZXJfdGltZW91dCk7CiAjZW5kaWYKIC8qCi0gKiBEZXZpY2UgWzgwODY6OWEwOV0KKyAqIERl
dmljZSBbODA4Njo5YTA5XSwgWzgwODY6YTBiMF0gYW5kIFs4MDg2OmEwYmNdCiAgKiBCSU9T
IG1heSBub3QgYmUgYWJsZSB0byBhY2Nlc3MgY29uZmlnIHNwYWNlIG9mIGRldmljZXMgdW5k
ZXIgVk1EIGRvbWFpbiwgc28KICAqIGl0IHJlbGllcyBvbiBzb2Z0d2FyZSB0byBlbmFibGUg
QVNQTSBmb3IgbGlua3MgdW5kZXIgVk1ELgogICovCitzdGF0aWMgY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgdm1kX2JyaWRnZV90YmxbXSA9IHsKKwl7IFBDSV9WREVWSUNFKElOVEVM
LCAweDlhMDkpIH0sCisJeyBQQ0lfVkRFVklDRShJTlRFTCwgMHhhMGIwKSB9LAorCXsgUENJ
X1ZERVZJQ0UoSU5URUwsIDB4YTBiYykgfSwKKwl7IH0KK307CisKIHN0YXRpYyB2b2lkIHBj
aV9maXh1cF9lbmFibGVfYXNwbShzdHJ1Y3QgcGNpX2RldiAqcGRldikKIHsKKwlpZiAoIXBj
aV9tYXRjaF9pZCh2bWRfYnJpZGdlX3RibCwgcGRldikpCisJCXJldHVybjsKKwogCXBkZXYt
PmRldl9mbGFncyB8PSBQQ0lfREVWX0ZMQUdTX0VOQUJMRV9BU1BNOwogfQotREVDTEFSRV9Q
Q0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4OWEwOSwgcGNpX2ZpeHVw
X2VuYWJsZV9hc3BtKTsKLURFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lE
X0lOVEVMLCAweGEwYjAsIHBjaV9maXh1cF9lbmFibGVfYXNwbSk7CitERUNMQVJFX1BDSV9G
SVhVUF9DTEFTU19IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0FOWV9JRCwKKwkJ
CSAgICAgICBQQ0lfQ0xBU1NfQlJJREdFX1BDSSwgOCwgcGNpX2ZpeHVwX2VuYWJsZV9hc3Bt
KTsKKworc3RhdGljIHZvaWQgcGNpX2ZpeHVwX2VuYWJsZV92bWRfbnZtZV9sdHIoc3RydWN0
IHBjaV9kZXYgKnBkZXYpCit7CisJc3RydWN0IHBjaV9kZXYgKnBhcmVudDsKKwlpbnQgcG9z
OworCXUxNiB2YWw7CisKKwlwYXJlbnQgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKHBkZXYpOwor
CWlmICghcGFyZW50KQorCQlyZXR1cm47CisKKwlpZiAoIXBjaV9tYXRjaF9pZCh2bWRfYnJp
ZGdlX3RibCwgcGFyZW50KSkKKwkJcmV0dXJuOworCisJcG9zID0gcGNpX2ZpbmRfZXh0X2Nh
cGFiaWxpdHkocGRldiwgUENJX0VYVF9DQVBfSURfTFRSKTsKKwlpZiAoIXBvcykKKwkJcmV0
dXJuOworCisJcGNpX3JlYWRfY29uZmlnX3dvcmQocGRldiwgcG9zICsgUENJX0xUUl9NQVhf
U05PT1BfTEFULCAmdmFsKTsKKwlpZiAodmFsKQorCQlyZXR1cm47CisKKwlwY2lfcmVhZF9j
b25maWdfd29yZChwZGV2LCBwb3MgKyBQQ0lfTFRSX01BWF9OT1NOT09QX0xBVCwgJnZhbCk7
CisJaWYgKHZhbCkKKwkJcmV0dXJuOworCisJLyogMzE0NTcyOG5zLCBpLmUuIDB4MzAwMDAw
bnMgKi8KKwlwY2lfd3JpdGVfY29uZmlnX3dvcmQocGRldiwgcG9zICsgUENJX0xUUl9NQVhf
U05PT1BfTEFULCAweDEwMDMpOworCXBjaV93cml0ZV9jb25maWdfd29yZChwZGV2LCBwb3Mg
KyBQQ0lfTFRSX01BWF9OT1NOT09QX0xBVCwgMHgxMDAzKTsKK30KK0RFQ0xBUkVfUENJX0ZJ
WFVQX0NMQVNTX0VBUkxZKFBDSV9BTllfSUQsIFBDSV9BTllfSUQsCisJCQkgICAgICBQQ0lf
Q0xBU1NfU1RPUkFHRV9FWFBSRVNTLCAwLCBwY2lfZml4dXBfZW5hYmxlX3ZtZF9udm1lX2x0
cik7Ci0tIAoyLjQzLjAKCg==
--------------FPjnJnb9m0lJwSNN9jesde4K
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-UBUNTU-SAUCE-vmd-fixup-bridge-ASPM-by-driver-name-in.patch"
Content-Disposition: attachment;
 filename*0="0001-UBUNTU-SAUCE-vmd-fixup-bridge-ASPM-by-driver-name-in.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyNTVlMzQ1YTZhYjFjNTNmOTYwN2M0MWRhYTFlYWZhYzRiZjgzZTBkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBZb3UtU2hlbmcgWWFuZyA8dmljYW1vLnlhbmdAY2Fu
b25pY2FsLmNvbT4KRGF0ZTogTW9uLCAxMSBBcHIgMjAyMiAxNzoyNDozNCArMDgwMApTdWJq
ZWN0OiBbUEFUQ0hdIFVCVU5UVTogU0FVQ0U6IHZtZDogZml4dXAgYnJpZGdlIEFTUE0gYnkg
ZHJpdmVyIG5hbWUgaW5zdGVhZAoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5u
ZXQvYnVncy8xOTQyMTYwCgpBZGRpdGlvbmFsIFZNRCBicmlkZ2UgSURzIG5lZWRlZCBmb3Ig
bmV3IEFsZGVyIExha2UgcGxhdGZvcm1zLCBidXQKYWN0dWFsbHkgdGhlcmUgaXMgbm8gYSBj
b21wbGV0ZSBsaXN0IGZvciB0aGVtLiBIZXJlIHdlIG1hdGNoIGJyaWRnZQpkZXZpY2VzIGlm
IHRoZXkncmUgZGlyZWN0bHkgYXR0YWNoZWQgdG8gYSBWTUQgY29udHJvbGxlciBpbnN0ZWFk
LgoKU2lnbmVkLW9mZi1ieTogWW91LVNoZW5nIFlhbmcgPHZpY2Ftby55YW5nQGNhbm9uaWNh
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEFuZHJlYSBSaWdoaSA8YW5kcmVhLnJpZ2hpQGNhbm9u
aWNhbC5jb20+CihjaGVycnkgcGlja2VkIGZyb20gY29tbWl0IDE1NGQ0OGRhMmM1NzUxNGU0
YjVkYWRjN2I4YzcwYTRlZGI1NTA5ODEpCi0tLQogZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAz
MiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIz
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCA0ZjExNmVmMzJmNzAu
LjNlNjlkNzUyNDJmZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMKKysrIGIv
ZHJpdmVycy9wY2kvcXVpcmtzLmMKQEAgLTYyNzgsMjMgKzYyNzgsMzYgQEAgREVDTEFSRV9Q
Q0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9HTEksIDB4OTc1MCwgcGNpX21hc2tfcmVw
bGF5X3RpbWVyX3RpbWVvdXQKIERFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1Jf
SURfR0xJLCAweDk3NTUsIHBjaV9tYXNrX3JlcGxheV90aW1lcl90aW1lb3V0KTsKICNlbmRp
ZgogLyoKLSAqIERldmljZSBbODA4Njo5YTA5XSwgWzgwODY6YTBiMF0gYW5kIFs4MDg2OmEw
YmNdCiAgKiBCSU9TIG1heSBub3QgYmUgYWJsZSB0byBhY2Nlc3MgY29uZmlnIHNwYWNlIG9m
IGRldmljZXMgdW5kZXIgVk1EIGRvbWFpbiwgc28KICAqIGl0IHJlbGllcyBvbiBzb2Z0d2Fy
ZSB0byBlbmFibGUgQVNQTSBmb3IgbGlua3MgdW5kZXIgVk1ELgogICovCi1zdGF0aWMgY29u
c3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgdm1kX2JyaWRnZV90YmxbXSA9IHsKLQl7IFBDSV9W
REVWSUNFKElOVEVMLCAweDlhMDkpIH0sCi0JeyBQQ0lfVkRFVklDRShJTlRFTCwgMHhhMGIw
KSB9LAotCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4YTBiYykgfSwKLQl7IH0KLX07CitzdGF0
aWMgYm9vbCBwY2lfZml4dXBfaXNfdm1kX2JyaWRnZShzdHJ1Y3QgcGNpX2RldiAqcGRldikK
K3sKKwlzdHJ1Y3QgcGNpX2J1cyAqYnVzID0gcGRldi0+YnVzOworCXN0cnVjdCBkZXZpY2Ug
KmRldjsKKwlzdHJ1Y3QgcGNpX2RyaXZlciAqcGRydjsKKworCWlmICghcGNpX2lzX3Jvb3Rf
YnVzKGJ1cykpCisJCXJldHVybiBmYWxzZTsKKworCWRldiA9IGJ1cy0+YnJpZGdlLT5wYXJl
bnQ7CisJaWYgKGRldiA9PSBOVUxMKQorCQlyZXR1cm4gZmFsc2U7CisKKwlwZHJ2ID0gcGNp
X2Rldl9kcml2ZXIodG9fcGNpX2RldihkZXYpKTsKKwlpZiAocGRydiA9PSBOVUxMIHx8IHN0
cmNtcCgidm1kIiwgcGRydi0+bmFtZSkpCisJCXJldHVybiBmYWxzZTsKKworCXJldHVybiB0
cnVlOworfQogCiBzdGF0aWMgdm9pZCBwY2lfZml4dXBfZW5hYmxlX2FzcG0oc3RydWN0IHBj
aV9kZXYgKnBkZXYpCiB7Ci0JaWYgKCFwY2lfbWF0Y2hfaWQodm1kX2JyaWRnZV90YmwsIHBk
ZXYpKQorCWlmICghcGNpX2ZpeHVwX2lzX3ZtZF9icmlkZ2UocGRldikpCiAJCXJldHVybjsK
IAogCXBkZXYtPmRldl9mbGFncyB8PSBQQ0lfREVWX0ZMQUdTX0VOQUJMRV9BU1BNOworCXBj
aV9pbmZvKHBkZXYsICJlbmFibGUgQVNQTSBmb3IgcGNpIGJyaWRnZSBiZWhpbmQgdm1kIik7
CiB9CiBERUNMQVJFX1BDSV9GSVhVUF9DTEFTU19IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRF
TCwgUENJX0FOWV9JRCwKIAkJCSAgICAgICBQQ0lfQ0xBU1NfQlJJREdFX1BDSSwgOCwgcGNp
X2ZpeHVwX2VuYWJsZV9hc3BtKTsKQEAgLTYzMDksNyArNjMyMiw3IEBAIHN0YXRpYyB2b2lk
IHBjaV9maXh1cF9lbmFibGVfdm1kX252bWVfbHRyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQog
CWlmICghcGFyZW50KQogCQlyZXR1cm47CiAKLQlpZiAoIXBjaV9tYXRjaF9pZCh2bWRfYnJp
ZGdlX3RibCwgcGFyZW50KSkKKwlpZiAoIXBjaV9maXh1cF9pc192bWRfYnJpZGdlKHBhcmVu
dCkpCiAJCXJldHVybjsKIAogCXBvcyA9IHBjaV9maW5kX2V4dF9jYXBhYmlsaXR5KHBkZXYs
IFBDSV9FWFRfQ0FQX0lEX0xUUik7CkBAIC02MzI3LDYgKzYzNDAsNyBAQCBzdGF0aWMgdm9p
ZCBwY2lfZml4dXBfZW5hYmxlX3ZtZF9udm1lX2x0cihzdHJ1Y3QgcGNpX2RldiAqcGRldikK
IAkvKiAzMTQ1NzI4bnMsIGkuZS4gMHgzMDAwMDBucyAqLwogCXBjaV93cml0ZV9jb25maWdf
d29yZChwZGV2LCBwb3MgKyBQQ0lfTFRSX01BWF9TTk9PUF9MQVQsIDB4MTAwMyk7CiAJcGNp
X3dyaXRlX2NvbmZpZ193b3JkKHBkZXYsIHBvcyArIFBDSV9MVFJfTUFYX05PU05PT1BfTEFU
LCAweDEwMDMpOworCXBjaV9pbmZvKHBkZXYsICJlbmFibGUgTFRSIGZvciBudm1lIGJlaGlu
ZCB2bWQiKTsKIH0KIERFQ0xBUkVfUENJX0ZJWFVQX0NMQVNTX0VBUkxZKFBDSV9BTllfSUQs
IFBDSV9BTllfSUQsCiAJCQkgICAgICBQQ0lfQ0xBU1NfU1RPUkFHRV9FWFBSRVNTLCAwLCBw
Y2lfZml4dXBfZW5hYmxlX3ZtZF9udm1lX2x0cik7Ci0tIAoyLjQzLjAKCg==

--------------FPjnJnb9m0lJwSNN9jesde4K--

