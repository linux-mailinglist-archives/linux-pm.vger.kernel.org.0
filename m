Return-Path: <linux-pm+bounces-28315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18054AD2599
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0A33B13F0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D721D3F4;
	Mon,  9 Jun 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codesensesolutions.com header.i=joe.walter@codesensesolutions.com header.b="agR7y074"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A021CC71
	for <linux-pm@vger.kernel.org>; Mon,  9 Jun 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493744; cv=none; b=AdLt3br4pLvNPy10Fv/kKSvSgiXESGAQo/xqwHfyMSxaz2pNTWntj3dkJNXWBdfGNtkuIj0m2bB0ARiV300JEtu2O905eGr4QwNijSnO0nw5oHtCuarHZgyPJoMME/R0ZrlYxRFzgG3ox+dSEA8W4QYFE1QjihIQcRETybPagh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493744; c=relaxed/simple;
	bh=Kaj00o+B2KXXV4WXwzq0v8aTYcoEOj2DcRQPSdeve3o=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=hawi0lMkrTxFBCDopXn/Aa0p4efYAB0F4c3z3qCidcsKYX9vfSZAV8jLA7fh71BeDoFiMfQ/Pj57kqPyFw1Z1BHXK4/BnQ3kO6qkkacFxfNONfQzlYqZw9GarF0uZYgXG8T3PqXvL5RvpUkQ7hcdD/tKyAEieUudLZaVBaSYWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesensesolutions.com; spf=pass smtp.mailfrom=codesensesolutions.com; dkim=pass (2048-bit key) header.d=codesensesolutions.com header.i=joe.walter@codesensesolutions.com header.b=agR7y074; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesensesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codesensesolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codesensesolutions.com; s=s1-ionos; t=1749493735; x=1750098535;
	i=joe.walter@codesensesolutions.com;
	bh=Ra5pxwXMJqZ6J3ljb2AJG1vu0fPUAPsgccbDXHMPw0M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Message-ID:Subject:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=agR7y0747kOHlVotYDHhrjRezXzFty9m6rUrnJRooBk3rkwqsdwIE/bZM9LLV7Tg
	 sqTCxVMhg+oAFJWztXlQUutqw9vnRD/jbQiHXuogyO6WKQP2DXID0b9iLDWQftbkp
	 pJLaY0ukBtvuXra0mrpu5iWjX1U5vIYKD+1aa6LzQhL9xe2J2OiE96THVsV/5ETrl
	 znU418kHx7wpdNSvkTlQlcY2WcRRUIaYM1XVFbTSJZ5WbOVoBk5BpDK4KcN4kmep9
	 ZTe21PgwJcJDnVdP8Amifwgp7iqJPCoL3+FBflXIJ2HgOQokqyH7U0to7oUonrfdV
	 PThDxta+NCVxS4py+Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from
 open-xchange-core-mw-default-0.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
 ([10.73.158.221]) by mrelay.perfora.net (mreueus002 [172.19.143.1]) with
 ESMTPSA (Nemesis) id 0Mgd8b-1u9eOe2AgJ-00ITVM; Mon, 09 Jun 2025 20:28:55
 +0200
Date: Mon, 9 Jun 2025 14:28:55 -0400 (EDT)
From: Joe Walter <joe.walter@codesensesolutions.com>
To: 
	"srinivas.pandruvada@intel.linux.com" <srinivas.pandruvada@intel.linux.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Message-ID: <639429100.102270.1749493735270@email.ionos.com>
Subject: [PATCH] cpufreq: intel_pstate: Add EPP default for Kaby Lake
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_102268_1670762611.1749493735269"
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.54
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:8D0IMAclchht8ICVkcFGjWl/uL0OUDZl2YjuQQqYEZh55UPe937
 7r6rkBgl7J+Yf3uSTdkKyPaL8sSStapEEXRvMkC3djmJDYX83T9cP+a7T3jWzlMtNbOYqw3
 rE5507WctRVY6bNqLHd3ELonxxrUIXNtNqIvTXd0d6BzjY+Y+DOjHyg1OhwzssPdkjGPhK4
 M3s6qp23OUAf//XlkGk8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QmX2vXzcgJQ=;AaFMVTOe2NmTrz5PvN8L7l8uhkz
 14+2rmp2sXyqdw/tO4TM4ufTvYBo3hbHiQNBAK0DWH23H+S8bg+jvBUN5OKQaL3qHcKxforYL
 NnolQNV2OlKhtijR52afwlCk7urzL8mKr8uAHdNHO7pNL/p64f5aoV/OP0bTqFxGr5aokVJ66
 mUH1U+Gw00nfbyd4KMUKKEB1V01Z8GujU+wOIjFl6o6wJyOcEFuRqMwZMjubCGvhkryKzc7RM
 1neXLvnB2z2cM66LtUrRQkZhGVQXCT84I7isQvMvj8+7d03/trAKzY7qwVMUCCt8KNn13VJJ8
 n9W+iZxuGrTYEEx75Ozr7MCr5nK+CsKAwMVVJ7p0iMkmH70jFqsIiYdjW2q5wP9zZ9TQjHHlt
 O6mTtOg3WZJ09BNchMq8jEHcbhRQMeIJdYCPyXdXfuPL8YSbX9yzBTNAj3ZrwlsOuwCxe1b7N
 exsbSG6fvNPrrKqULko0BisDbrtJPDBQILyefnIuh7StGAj+Pqd66Wr68gctJrbxmd5pqSoAS
 Qmov7tqzaVu17nIhxdeeITHFDsiktwPWzvYG//RGol58JfxlTnknwJWW0mVDSlj5PrVcxIFXG
 1Ccq1DUExn66l1mBb/22uP399IN5L+35YmT39bUT4Ht/rxVdoXhAtbHJbhop1CEK6ne6PRrYK
 Owsu5iWV++iWq1O5EudfZ/ggDtMzUH12QzD43EYyz9k/mqWA+L/KAVaf0d8bFp+LunM2Ogl+N
 IBb1sI/C/6zNxnnv7W6IMrV8AKIGsGmiOCLDggqceQjUtjO3s6gpiEVq08hX2RwYVJxGb+uCM
 t87w2B58vyLlQSH1q67viqrFpQoyEgeGOR/1bhWDIPVucAQgeo5Sb/UvQo/GtDeT+y0MWV5ka
 76wrE+apMmdEGEuLzW7m+LzTk1ppXHawujULIwUujqKIkVibGXLEmfIshUv37NvHKQFoxsDsT
 7Mj3WdccegD02ILMJIgbIVgTbY710v7WEnTX2+xKKz6RQgdgeb1Dhj6M9nOi6khUho0pVB43m
 0ZTNm1ju7zqrn17VttCtgkGMWmvKV9aIOiDIP77AG+J4kOCwtwC7+0uEto7wr42WxCHieO5R/
 Vf/B2MDQ663BwD/ZHgsKS1SGjgxGMDWohyKh5N+4vT0X3n0AmgB779Os/cFWmDFtYGBXShVVX
 /sJNHvzeRH+nnvFbHY3JV/0ApKyml7PSbidERxD+f7ijgRw+Opy3OPrCbJXO/kO9As1e09dR8
 T5hawI5Q9dlLp7WlzL+4jU85m0oUo84lmv1W4t7+hXtVegem1ZQ4f8DTPMjAGR8Tpog1tAohu
 Dn7q7FCSgtNzMt4acUxJ6B8fmz1L8VI6fNUc3mwc9PJRrqPlHvry5pHfFdzWXn/ozdZrFz5jV
 9mGdT4VWLe0D96rA==

------=_Part_102268_1670762611.1749493735269
Content-Type: multipart/alternative; 
	boundary="----=_Part_102269_1323572157.1749493735269"

------=_Part_102269_1323572157.1749493735269
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Srinivas,
Thank you for the clarification and your patience with my questions. You'r=
e absolutely right that EPP is working correctly and is a user choice.
=20
The issue I'm addressing is that Kaby Lake systems currently get a default=
 EPP value that causes suboptimal performance (900MHz frequency lock under=
 load), while users may not realize they need to manually adjust EPP setti=
ngs.
=20
My patch follows the existing pattern in the intel_epp_default[] table whe=
re other CPU families (Alder Lake, Sapphire Rapids, etc.) have optimized d=
efault EPP values set by the kernel.
=20
This ensures Kaby Lake systems work well "out of the box" while still allo=
wing users to override EPP settings as needed.
=20
Is this the correct approach, or would you prefer a different solution for=
 setting better defaults on Kaby Lake systems?
=20
I apologize for the multiple emails on this issue - I wanted to make sure =
I understood the proper solution. This will be my final submission on this=
 topic.
=20
Thanks for your patience,
Joe Walter

------=_Part_102269_1323572157.1749493735269
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!doctype html>
<html>
 <head>
  <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8"=
>
 </head>
 <body>
  <div class=3D"default-style">
   Hi Srinivas,=20
   <br>
    Thank you for the clarification and your patience with my questions. Y=
ou're absolutely right that EPP is working correctly and is a user choice.
  </div>
  <div class=3D"default-style">
   &nbsp;
  </div>
  <div class=3D"default-style">
   The issue I'm addressing is that Kaby Lake systems currently get a defa=
ult EPP value that causes suboptimal performance (900MHz frequency lock un=
der load), while users may not realize they need to manually adjust EPP se=
ttings.
  </div>
  <div class=3D"default-style">
   &nbsp;
  </div>
  <div class=3D"default-style">
   My patch follows the existing pattern in the intel_epp_default[] table =
where other CPU families (Alder Lake, Sapphire Rapids, etc.) have optimize=
d default EPP values set by the kernel.
  </div>
  <div class=3D"default-style">
   &nbsp;
  </div>
  <div class=3D"default-style">
   This ensures Kaby Lake systems work well "out of the box" while still a=
llowing users to override EPP settings as needed.
  </div>
  <div class=3D"default-style">
   &nbsp;
  </div>
  <div class=3D"default-style">
   Is this the correct approach, or would you prefer a different solution =
for setting better defaults on Kaby Lake systems?
  </div>
  <div class=3D"default-style">
   &nbsp;
  </div>
  <div class=3D"default-style">
   I apologize for the multiple emails on this issue - I wanted to make su=
re I understood the proper solution. This will be my final submission on t=
his topic.
  </div>
  <div class=3D"default-style">
   &nbsp;
  </div>
  <div class=3D"default-style">
   Thanks for your patience,=20
   <br>
    Joe Walter
  </div>
 </body>
</html>

------=_Part_102269_1323572157.1749493735269--

------=_Part_102268_1670762611.1749493735269
Content-Type: text/x-patch; charset=UTF-8;
 name=0001-cpufreq-intel_pstate-Add-EPP-default-for-Kaby-Lake.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-cpufreq-intel_pstate-Add-EPP-default-for-Kaby-Lake.patch
X-Part-Id: 494a41eea77a498eb67ed24bef00e85e

RnJvbSA3NzZhNDQ4M2U4NDIzNTcwMjA1ZjQyNzY4ZTUxMGFkMDAxMDUwODk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2UgV2FsdGVyIDxqb2Uud2FsdGVyQGNvZGVzZW5zZXNvbHV0
aW9ucy5jb20+CkRhdGU6IE1vbiwgOSBKdW4gMjAyNSAxMToxNTowNSAtMDcwMApTdWJqZWN0OiBb
UEFUQ0ggMS8xXSBjcHVmcmVxOiBpbnRlbF9wc3RhdGU6IEFkZCBFUFAgZGVmYXVsdCBmb3IgS2Fi
eSBMYWtlCgpLYWJ5IExha2UgcHJvY2Vzc29ycyAoZmFtaWx5IDYsIG1vZGVsIDE1OCkgZXhwZXJp
ZW5jZSBmcmVxdWVuY3kKc2NhbGluZyBpc3N1ZXMgd2hlcmUgdGhlIENQVSBnZXRzIGxvY2tlZCBh
dCBtaW5pbXVtIGZyZXF1ZW5jeQoofjkwME1IeikgdW5kZXIgbG9hZCB3aGVuIHVzaW5nIHRoZSBk
ZWZhdWx0IEVQUCB2YWx1ZS4KClRlc3Rpbmcgb24gRGVsbCBJbnNwaXJvbiBzeXN0ZW1zIHdpdGgg
aTUtNzMwMEhRIHNob3dzIHRoYXQgc2V0dGluZwpFUFAgdG8gSFdQX0VQUF9CQUxBTkNFX1BFUkZP
Uk1BTkNFICgxMjgpIHJlc29sdmVzIHRoZSBpc3N1ZSBhbmQKYWxsb3dzIHByb3BlciBmcmVxdWVu
Y3kgc2NhbGluZyB1cCB0byAzKyBHSHouCgpUaGlzIGFmZmVjdHMgYXQgbGVhc3QgRGVsbCBJbnNw
aXJvbiA3NTY3IHN5c3RlbXMsIGFuZCBsaWtlbHkgb3RoZXIKS2FieSBMYWtlIGxhcHRvcHMgd2l0
aCBzaW1pbGFyIHBvd2VyIG1hbmFnZW1lbnQgY29uZmlndXJhdGlvbnMuCgpSZXBvcnRlZC1ieTog
Sm9lIFdhbHRlciA8am9lLndhbHRlckBjb2Rlc2Vuc2Vzb2x1dGlvbnMuY29tPgpUZXN0ZWQtYnk6
IEpvZSBXYWx0ZXIgPGpvZS53YWx0ZXJAY29kZXNlbnNlc29sdXRpb25zLmNvbT4KRml4ZXM6IChF
UFAgZnJlcXVlbmN5IHNjYWxpbmcgaXNzdWVzIG9uIEthYnkgTGFrZSkKU2lnbmVkLW9mZi1ieTog
Sm9lIFdhbHRlciA8am9lLndhbHRlckBjb2Rlc2Vuc2Vzb2x1dGlvbnMuY29tPgotLS0KIGRyaXZl
cnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jIGIvZHJp
dmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCmluZGV4IDY0NTg3ZDMxODI2Ny4uZGM3OWRkNjI2
YjY3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMKKysrIGIvZHJp
dmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC0zNzgxLDYgKzM3ODEsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgaW50ZWxfZXBwX2RlZmF1bHRbXSA9IHsKIAlYODZfTUFU
Q0hfVkZNKElOVEVMX0VNRVJBTERSQVBJRFNfWCwgSFdQX1NFVF9ERUZfQkFMQU5DRV9QRVJGX0VQ
UCgzMikpLAogCVg4Nl9NQVRDSF9WRk0oSU5URUxfR1JBTklURVJBUElEU19YLCBIV1BfU0VUX0RF
Rl9CQUxBTkNFX1BFUkZfRVBQKDMyKSksCiAJWDg2X01BVENIX1ZGTShJTlRFTF9HUkFOSVRFUkFQ
SURTX0QsIEhXUF9TRVRfREVGX0JBTEFOQ0VfUEVSRl9FUFAoMzIpKSwKKwlYODZfTUFUQ0hfVkZN
KElOVEVMX0tBQllMQUtFLCBIV1BfU0VUX0RFRl9CQUxBTkNFX1BFUkZfRVBQKDEyOCkpLAogCVg4
Nl9NQVRDSF9WRk0oSU5URUxfTUVURU9STEFLRV9MLCBIV1BfU0VUX0VQUF9WQUxVRVMoSFdQX0VQ
UF9QT1dFUlNBVkUsCiAJCSAgICAgIDE3OSwgNjQsIDE2KSksCiAJWDg2X01BVENIX1ZGTShJTlRF
TF9BUlJPV0xBS0UsIEhXUF9TRVRfRVBQX1ZBTFVFUyhIV1BfRVBQX1BPV0VSU0FWRSwKLS0gCjIu
NDguMQoK
------=_Part_102268_1670762611.1749493735269--

