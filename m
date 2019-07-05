Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9983260889
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfGEO7W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 10:59:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:45775 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGEO7V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jul 2019 10:59:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 07:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="p7s'?scan'208";a="191649513"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2019 07:59:21 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.170]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.186]) with mapi id 14.03.0439.000;
 Fri, 5 Jul 2019 07:59:20 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 00/13] intel_rapl: RAPL abstraction and MMIO RAPL
 support
Thread-Topic: [PATCH V2 00/13] intel_rapl: RAPL abstraction and MMIO RAPL
 support
Thread-Index: AQHVMoZl+7Q2s7XLCU6KhPo+AxVOZKa8L4QAgABlOYA=
Date:   Fri, 5 Jul 2019 14:59:19 +0000
Message-ID: <97215b43ce11766f83847531b05def8d94f645f0.camel@intel.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0jZEcSpGqeccZwOw6a_QMXKdcx4K2GBeC8P0Vn-9E6vyQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jZEcSpGqeccZwOw6a_QMXKdcx4K2GBeC8P0Vn-9E6vyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.68]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-9G+TwDK9UkG8OAON5b+f"
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--=-9G+TwDK9UkG8OAON5b+f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-07-05 at 10:57 +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 4, 2019 at 6:34 PM Zhang Rui <rui.zhang@intel.com> wrote:
> >=20
> > Besideis MSR interface, RAPL can also be controlled via the MMIO
> > interface,
> > by accessing the MCHBar registers exposed by the processor thermal
> > device.
> >=20
> > Currently, we only have RAPL MSR interface in Linux kernel, this
> > brings
> > problems on some platforms that BIOS performs a low power limits
> > via the
> > MMIO interface by default. This results in poor system performance,
> > and there is no way for us to change the MMIO MSR setting in Linux.
> >=20
> > To fix this, RAPL MMIO interface support is introduced in this
> > patch set.
> >=20
> > Patch 1/13 to patch 11/13 abstract the RAPL code, and move all the
> > shared
> > code into a separate file, intel_rapl_common.c, so that it can be
> > used
> > by both MSR and MMIO interfaces.
> > Patch 12/13 introduced RAPL support via MMIO registers, exposed by
> > the
> > processor thermal devices.
> > Patch 13/13 fixes a module autoloading issue found later.
> >=20
> > The patch series has been tested on Dell XPS 9360, a SKL platform.
> >=20
> > Note that this patch series are based on the -tip tree, which
> > contains the
> > latest RAPL changes for multi-die support.
> >=20
> > Changes in V2:
> >    - add kerneldoc for struct rapl_if_priv.
> >    - use intel_rapl_msr.c for RAPL MSR I/F driver, instead of
> > intel_rapl.c.
> >    - changelog and coding style update.
>=20
> What tree is the series against?
>=20
> It doesn't apply either on top of my powercap branch or on top of
> 5.2-rc7 for me.
This needs linux tip tree. There are some package/die changes in tip
tree, which this patch depends on.

Thanks,
Srinivas


--=-9G+TwDK9UkG8OAON5b+f
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
n4IJlKBiiK7B8oFPhD7KEZOWboHrE2uHLEkIXpp852sG0oFkLLstEDK9Z46WS4Ni1yfGRE6jY79A
DJOEZIX9AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUZ2w0kbL1uZEoQTmAiMqoAXL81L8wHwYDVR0j
BBgwFoAU2kEjnFqPca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEIuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29j
c3AuaW50ZWwuY29tLzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9y
eS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIw
NEIuY3J0MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQAXirNmyawI/PJRnjPoqNcgSr8N
8VXBvv8kwQidSNWKswBqo8ul8u+pkG7v8YjZUy1OJQUFXPvihht10Tb5O2xZ9hpIo4WFcRX2eg2Z
t6koRJUB9ZDjEETG2j4EpcGmWIBrDBNZLZTLIYG5JzsS6mGCq42AKspSAJD00vwfL0KlCc4BVUvC
64+q7etbf6c90n05KjfLfoUXBqwWLJCe3KPD20d/kbvesTzs2PVQxI7K1eL9n2rBoqBpcRY0ppkz
FKjiTQ8IcwhyWQbzLfVIy5tNuyinhNBRv3COOMGoayaljijEPcEHLE63tA2OIao2Hz6GLRYzg0mT
hCtsB4xSboPZMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAGknngjvas7THxUAAAAAaScwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDcw
NTE0NTkxOVowIwYJKoZIhvcNAQkEMRYEFByCdNlTFJWdYbE3ZwqIuH4kft72MA0GCSqGSIb3DQEB
AQUABIIBAHGt0qpFEt4Z4R3XXeKgtVjK9gj55Qi9C5bCDtuS6Hx4VbmBCV1CLQEjYDbCk2U+NJ9r
/3Whvh1xTM3UcmVglgMAd4Fs0687dmJpAEMZ937WmYqoEFaEeq7/il6JhDEUykV3xjao56HzProu
DWUTzpCNlYI/xq5Nltx+HqHuGtNUQBvw6Oyk9k6Zp/9dITXZ61dgpgkEB++sUln5d1FLlrC7iJup
fO5iEajmbBmR9+C3Gq9tVQqi2Px821kRftEW3S0d9JVyFdq797sQU4J/uTsTJwEQhXIAnPIjoAcO
PtA7Ec34S+OrWF2uyXsBzqOvJTMsRtvi24E3nmQS746sLscAAAAAAAA=


--=-9G+TwDK9UkG8OAON5b+f--
