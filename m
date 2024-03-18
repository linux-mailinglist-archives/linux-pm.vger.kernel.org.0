Return-Path: <linux-pm+bounces-5068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B398C87EFD4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 19:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF7A28464C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73898208A4;
	Mon, 18 Mar 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="at+PquVZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D022083;
	Mon, 18 Mar 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787007; cv=none; b=DLELO6tNGSue9/CotGqd55smD5Zb0yIVFI5iOt9mRo4ujb66DpeKimgOL40HvWct7FCF7zomUgKBA92Hbh3FPhWaxpF2K81y9cF3pFNXECK+Y80B2WxeOeV2epNSAyugsVm0EVXNeQGYZ0C8uu6K7vGGmBQFx7bmjjQLH/5FTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787007; c=relaxed/simple;
	bh=r2nAT2sGU3plCHjFU/Vpww/3KM683f6GTYQsbjLCPyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhJYXKmZMtPos2GlXkGjlP5ES2aeEuMSH5mchX1j5pjOsjR//ulHOR4ZONvIFRunbp7FIGaWExY0SEa21TjZDqjQcPNdSJwbbbZAi16wjqyDvrtMie2FT3/Zcv78vehK4duwdlj8BgdJUF7sCeOaVNi7CE0i1wg8yfiufuQjELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=at+PquVZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r2nAT2sGU3plCHjFU/Vpww/3KM683f6GTYQsbjLCPyE=; b=at+PquVZbTmgs5jYE1m2owXZ7S
	yEECvMInK5wSFCu+ZMD/zLVIQjWBEPUAfe52JPLwhp+rAfggJhaD/4tWR+mjRBet6ybamjhvxgahK
	PKY01PdNb0dJHtexNRCQxA3yquAkOnqWrIof/v3I195/SiiGXXm0fizKtqbpq/xJQqsiLYHzbSU5a
	BjVYhrfcWMLI67mA8nZB1pTysyuLD8s4RyLCtsj7m+CjRJFmUmBjw1ulOd7feWeXln1OhJ6Hw4y2w
	CiFCWT1IwgE4Gjh4aIJdJf8B1maWwpm22DPoKj8s8u7IGYW76N9f/gHhgXD2fRXIPh7djJhsRia29
	6Ymp5tDg==;
Received: from [2001:8b0:10b:5:d467:67b2:6675:b6a9] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmHqk-00000000AKz-1HiF;
	Mon, 18 Mar 2024 18:36:42 +0000
Message-ID: <3180b428f221aa2551923688f5dc390a26d054e9.camel@infradead.org>
Subject: Re: [RFC PATCH v2 0/4] arm64: Add PSCI v1.3 SYSTEM_OFF2 support for
 hibernation
From: David Woodhouse <dwmw2@infradead.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Mostafa Saleh
 <smostafa@google.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev,  linux-pm@vger.kernel.org
Date: Mon, 18 Mar 2024 18:36:41 +0000
In-Reply-To: <86plvrz91f.wl-maz@kernel.org>
References: <20240318164646.1010092-1-dwmw2@infradead.org>
	 <86wmpzzdep.wl-maz@kernel.org>
	 <eb9215850e8231ab8ef75f523925be671cc6f5a0.camel@infradead.org>
	 <86ttl3zbd3.wl-maz@kernel.org>
	 <5d8394e6c2c77093eca0ecaf355da77eba710dc1.camel@infradead.org>
	 <86plvrz91f.wl-maz@kernel.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-3zzyIunDalwX2E7Bw/W/"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-3zzyIunDalwX2E7Bw/W/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-03-18 at 18:31 +0000, Marc Zyngier wrote:
> On Mon, 18 Mar 2024 18:15:36 +0000,
> David Woodhouse <dwmw2@infradead.org> wrote:
> >=20
> > [1=C2=A0 <text/plain; UTF-8 (quoted-printable)>]
> > On Mon, 2024-03-18 at 17:41 +0000, Marc Zyngier wrote:
> > > On Mon, 18 Mar 2024 17:26:07 +0000,
> > > David Woodhouse <dwmw2@infradead.org> wrote:
> > > >=20
> > > > [1=C2=A0 <text/plain; UTF-8 (quoted-printable)>]
> > > > On Mon, 2024-03-18 at 16:57 +0000, Marc Zyngier wrote:
> > > > >=20
> > > > > >=20
> > > > > > There *is* a way for a VMM to opt *out* of newer PSCI versions.=
.. by=20
> > > > > > setting a per-vCPU "special" register that actually ends up set=
ting the=20
> > > > > > PSCI version KVM-wide. Quite why this isn't just a simple KVM_C=
AP, I=20
> > > > > > have no idea.
> > > > >=20
> > > > > Because the expectations are that the VMM can blindly save/restor=
e the
> > > > > guest's state, including the PSCI version, and restore that blind=
ly.
> > > > > KVM CAPs are just a really bad design pattern for this sort of th=
ings.
> > > >=20
> > > > Hm, am I missing something here? Does the *guest* get to set the PS=
CI
> > > > version somehow, and opt into the latest version that it understand=
s
> > > > regardless of what the firmware/host can support?
> > >=20
> > > No. The *VMM* sets the PSCI version by writing to a pseudo register.
> > > It means that when the guest migrates, the VMM saves and restores tha=
t
> > > version, and the guest doesn't see any change.
> >=20
> > And when you boot a guest image which has been working for years under
> > a new kernel+KVM, your guest suddenly experiences a new PSCI version.
> > As I said that's not just new optional functions; it's potentially even
> > returning new error codes to the functions that said guest was already
> > using.
>=20
> If you want to stick to a given PSCI version, you write the version
> you want.
>=20
> >=20
> > And when you *hibernate* a guest and then launch it again under a newer
> > kernel+KVM, it experiences the same incompatibility.
> >=20
> > Unless the VMM realises this problem and opts *out* of the newer KVM
> > behaviour, of course. This is very much unlike how we *normally* expose
> > new KVM capabilities.
>=20
> This was discussed at length 5 or 6 years ago (opt-in vs opt-out).
>=20
> The feedback from QEMU (which is the only public VMM that does
> anything remotely useful with this) was that opt-out was a better
> model, specially as PSCI is the conduit for advertising the Spectre
> mitigations and users (such as certain cloud vendors) were pretty keen
> on guests seeing the mitigations advertised *by default*.

OK.

> And if you can spot any form of "normality" in the KVM interface, I'll
> buy you whatever beer you want. It is all inconsistent crap, so I
> think we're in pretty good company here.

I'll give you that one :)

> >=20
> > > > I don't think we ever aspired to be able to hand an arbitrary KVM f=
d to
> > > > a userspace VMM and have the VMM be able to drive that VM without
> > > > having any a priori context, did we?
> > >=20
> > > Arbitrary? No. This is actually very specific and pretty well
> > > documented.
> > >=20
> > > Also, to answer your question about why we treat 0.1 differently from
> > > 0.2+: 0.1 didn't specify the PSCI SMC/HCR encoding, meaning that KVM
> > > implemented something that was never fully specified. The VMM has to
> > > provide firmware tables that describe that. With 0.2+, there is a
> > > standard encoding for all functions, and the VMM doesn't have to
> > > provide the encoding to the guest.
> >=20
> > Gotcha. So for that case we were *forced* to do things correctly and
> > allow userspace to opt-in to the capability. While for 0.2 onwards we
> > got away with this awfulness of silently upgrading the version without
> > VMM consent.
> >=20
> > I was hoping to just follow the existing model of SYSTEM_RESET2 and not
> > have to touch this awfulness with a barge-pole, but sure, whatever you
> > want.
>=20
> Unless I'm reading the whole thing wrong (which isn't impossible given
> that I'm jet-lagged to my eyeballs), SYSTEM_RESET2 doesn't have any
> form of configuration. If PSCI 1.1 is selected, SYSTEM_RESET2 is
> available. So that'd be the model to follow.

Sorry, that was supposed to be SYSTEM_SUSPEND not SYSTEM_RESET2. But
OK.=20

--=-3zzyIunDalwX2E7Bw/W/
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwMzE4MTgzNjQxWjAvBgkqhkiG9w0BCQQxIgQghMcU0lAI
7jG8gd2UK11RETl8wNNrWpBN7Ei5ESVAr3owgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAgsjHsRsHzicTjklIUAN4nWB9T6JsWhe/n
qQN1AXUsUzcuPrqPwIaIWeughjhQBgN0b381Zg/vNO+adOFUuaGP8xZl8HGzUwF00ahoL/usiUpA
NMSlvQOMzNlxtTL54m1Oeh05lG6R07avQ/KL9lMcm8xlXCTdQGS0GfzRUJM+5M/7ZeS0r4LX5p8A
3b+Lq0E4JskVDBYeMHZI8efOpOgK7ITi/8OtgZLkRv24Fr1aLe1xb8AgrW4GTQ0Yokp/PNAn4vJU
pfUa47CTD8XJtbssvMh8L0Q7nXxWth0yejSKDJhtayy0km65YWqqB/G/DX3Ta6OCfMioln+E6Cem
QjHF08I6wQUr+cq7lr9cwGXvTblcTCAwQtAlL1KrGhaE2ZKE+UaQiFQb0b1Vu227WLA85TkaxU2E
jf1yGXNr1LwPmBsqQAdJKtLMSlNEO1Mv5e9nIsUFp4JPru3Py3mj0BW+fWrr8pTJ1oGz20o9TAuu
1uYCVH5Cral7zRFYCg/dV79T6qtioB8vIp4SUTRntEtD9myOUt/o43VMTC9ZADg1zisZg5U5XUvK
f5DzIEF3DcnHMXWnY6wUNpuqTHYOYQcguFOgrqAQ50ZaUTtj5L4m9BpGuxXkP5OxJMKZRZTjK68I
cxkQdKqlH8ltrRmrV7YaB4V3/7THf+2sqACJtxyHHAAAAAAAAA==


--=-3zzyIunDalwX2E7Bw/W/--

