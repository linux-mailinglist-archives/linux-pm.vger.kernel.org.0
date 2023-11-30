Return-Path: <linux-pm+bounces-526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1937FE5F8
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 02:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364D02821BD
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70F290D;
	Thu, 30 Nov 2023 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3130910C6
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 17:24:08 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f9efd5303cso204042fac.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 17:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701307447; x=1701912247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=050/UY4g1ikE72OZsbvqHGx2pf2Zpp3yEwnvu2jt/ag=;
        b=XFuu/Ya+49ym+lCfKG7NmehHRtPvXBuaJ71LfzxPZPtXbvt6afqXgjjsoG4heeYvg/
         6yu0hG9IjIpMvpt0IYbP4gx+vMBElzzgmFBvEfBO9fcN9hEoGT41RAfDol0s6r50/efo
         17E32MUKc4fqqSk2C2B2mt8ZGGtwn+6e1erzuW4WGhzX8E+YSjfs+N1KadlZsVLVwDJ5
         2Pu4w86aqksIARU5G6DEEFj+dGEgZRddFkssW7Kh65nk/G8IHKOfnpfega/Xccdd5/JF
         89c0dT3i+E/AlRyC6p6w41/t0T9MP1gEETSdYwRxtc6SQSUCObkeWquqKDtOhP/8e5rY
         XS3Q==
X-Gm-Message-State: AOJu0Yy7GK+OSBHmAIjqgGRDsAkZJ49RcFMUn9/IEHmhszz0xAEXnei6
	c+N3cweF0RifH4hOajByJL9zh0sN29a9amRVqVc=
X-Google-Smtp-Source: AGHT+IFn2MVLZZuZ5jnh7Vus0Yhy7ghnmrwgoDVg2VrmBjqYAMNJ87o7RizHr3+wcdE+JjxnvjTu7Jbwr61P9npwCBg=
X-Received: by 2002:a05:6870:a9aa:b0:1fa:3dee:ec38 with SMTP id
 ep42-20020a056870a9aa00b001fa3deeec38mr16682053oab.12.1701307447489; Wed, 29
 Nov 2023 17:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00d201d96670$e15ab9d0$a4102d70$@telus.net> <CAJvTdKmv-6rp=z=emS1VGdWgTmRfhSUrmUPLk8Hj+5=CvH0+nw@mail.gmail.com>
 <CAJvTdKmG2JkJBy4UNc101JZUHzUaC=a=U9Xwg9MgQs7wcDvYrA@mail.gmail.com>
 <001b01da22dc$e0f764b0$a2e62e10$@telus.net> <CAJvTdK=Bvkw+ro_quJ3y=+GAf1MHv5AiBu2kAY+V3Wn259maAg@mail.gmail.com>
In-Reply-To: <CAJvTdK=Bvkw+ro_quJ3y=+GAf1MHv5AiBu2kAY+V3Wn259maAg@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 29 Nov 2023 20:23:56 -0500
Message-ID: <CAJvTdK=rJfjgyRdg4-=xecEmcYnP86R4-K98KBgwa_6THitcPA@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix added raw MSR output
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000010061f060b5482a3"

--00000000000010061f060b5482a3
Content-Type: text/plain; charset="UTF-8"

> if (topo.num_packages == 1)

turns out that is topo.num_packages == 0...

Doug,
Let me know if this tweak to your patch doesn't do the trick.

thanks,
-Len

--00000000000010061f060b5482a3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-tools-power-turbostat-Fix-added-raw-MSR-output.patch"
Content-Disposition: attachment; 
	filename="0004-tools-power-turbostat-Fix-added-raw-MSR-output.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpkigz1p0>
X-Attachment-Id: f_lpkigz1p0

RnJvbSA0ZGI2Mjk2NjVkODUyNGY3MDViODZjODUyOWM2OWY3NTg5YjM5YzdiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NGRiNjI5NjY1ZDg1MjRmNzA1Yjg2Yzg1MjljNjlm
NzU4OWIzOWM3Yi4xNzAxMzA3MjI1LmdpdC5sZW4uYnJvd25AaW50ZWwuY29tPgpJbi1SZXBseS1U
bzogPDdmOTMxMDAyNTdlZDlmNDI2YzVjMzY1NjY4NmE1ZjU3ZDdkOTgwMGUuMTcwMTMwNzIyNS5n
aXQubGVuLmJyb3duQGludGVsLmNvbT4KUmVmZXJlbmNlczogPDdmOTMxMDAyNTdlZDlmNDI2YzVj
MzY1NjY4NmE1ZjU3ZDdkOTgwMGUuMTcwMTMwNzIyNS5naXQubGVuLmJyb3duQGludGVsLmNvbT4K
RnJvbTogRG91ZyBTbXl0aGllcyA8ZHNteXRoaWVzQHRlbHVzLm5ldD4KRGF0ZTogTW9uLCAzIEFw
ciAyMDIzIDE0OjExOjM4IC0wNzAwClN1YmplY3Q6IFtQQVRDSCA0LzRdIHRvb2xzL3Bvd2VyIHR1
cmJvc3RhdDogRml4IGFkZGVkIHJhdyBNU1Igb3V0cHV0ClJlcGx5LVRvOiBMZW4gQnJvd24gPGxl
bmJAa2VybmVsLm9yZz4KT3JnYW5pemF0aW9uOiBJbnRlbCBPcGVuIFNvdXJjZSBUZWNobm9sb2d5
IENlbnRlcgoKV2hlbiB1c2luZyAtLVN1bW1hcnkgbW9kZSwgYWRkZWQgTVNScyBpbiByYXcgbW9k
ZSBhbHdheXMKcHJpbnQgemVyb3MuIFByaW50IHRoZSBhY3R1YWwgcmVnaXN0ZXIgY29udGVudHMu
CgpFeGFtcGxlLCB3aXRoIHBhdGNoOgoKbm90ZSB0aGUgYWRkZWQgY29sdW1uOgotLWFkZCBtc3Iw
eDY0Zix1MzIscGFja2FnZSxyYXcsUkVBU09OCgpXaGVyZToKCjB4NjRGIGlzIE1TUl9DT1JFX1BF
UkZfTElNSVRfUkVBU09OUwoKQnVzeSUgICBCenlfTUh6IFBrZ1RtcCAgUGtnV2F0dCBDb3JXYXR0
ICAgICBSRUFTT04KMC4wMCAgICA0ODAwICAgIDM1ICAgICAgMS40MiAgICAwLjc2ICAgIDB4MDAw
MDAwMDAKMC4wMCAgICA0ODAxICAgIDM0ICAgICAgMS40MiAgICAwLjc2ICAgIDB4MDAwMDAwMDAK
ODAuMDggICA0NTMxICAgIDY2ICAgICAgMTA4LjE3ICAxMDcuNTIgIDB4MDgwMDAwMDAKOTguNjkg
ICA0NTMwICAgIDY2ICAgICAgMTMzLjIxICAxMzIuNTQgIDB4MDgwMDAwMDAKOTkuMjggICA0NTA1
ICAgIDY2ICAgICAgMTI4LjI2ICAxMjcuNjAgIDB4MGMwMDA0MDAKOTkuNjUgICA0NDg2ICAgIDY4
ICAgICAgMTI0LjkxICAxMjQuMjUgIDB4MGMwMDA0MDAKOTkuNjMgICA0NDgzICAgIDY4ICAgICAg
MTI0LjkwICAxMjQuMjUgIDB4MGMwMDA0MDAKNzkuMzQgICA0NDgxICAgIDQxICAgICAgOTkuODAg
ICA5OS4xMyAgIDB4MGMwMDAwMDAKMC4wMCAgICA0ODAxICAgIDQxICAgICAgMS40MCAgICAwLjcz
ICAgIDB4MGMwMDAwMDAKCldoZXJlLCBmb3IgdGhlIHRlc3QgcHJvY2Vzc29yIChpNS0xMDYwMEsp
OgoKUEtHIExpbWl0ICMxOiAxMjUuMDAwIFdhdHRzLCA4LjAwMDAwMCBzZWMKTVNSIGJpdCAyNiA9
IGxvZzsgYml0IDEwID0gc3RhdHVzCgpQS0cgTGltaXQgIzI6IDEzNi4wMDAgV2F0dHMsIDAuMDAy
NDQxIHNlYwpNU1IgYml0IDI3ID0gbG9nOyBiaXQgMTEgPSBzdGF0dXMKCkV4YW1wbGUsIHdpdGhv
dXQgcGF0Y2g6CgpCdXN5JSAgIEJ6eV9NSHogUGtnVG1wICBQa2dXYXR0IENvcldhdHQgICAgIFJF
QVNPTgowLjAxICAgIDQ4MDAgICAgMzUgICAgICAxLjQzICAgIDAuNzcgICAgMHgwMDAwMDAwMAow
LjAwICAgIDQ4MDEgICAgMzUgICAgICAxLjM5ICAgIDAuNzMgICAgMHgwMDAwMDAwMAo4My40OSAg
IDQ1MzEgICAgNjYgICAgICAxMTIuNzEgIDExMi4wNiAgMHgwMDAwMDAwMAo5OC42OSAgIDQ1MzAg
ICAgNjggICAgICAxMzMuMzUgIDEzMi42OSAgMHgwMDAwMDAwMAo5OS4zMSAgIDQ1MDAgICAgNjcg
ICAgICAxMjcuOTYgIDEyNy4zMCAgMHgwMDAwMDAwMAo5OS42MyAgIDQ0ODMgICAgNjkgICAgICAx
MjQuOTEgIDEyNC4yNSAgMHgwMDAwMDAwMAo5OS42MSAgIDQ0ODEgICAgNjkgICAgICAxMjQuOTAg
IDEyNC4yNSAgMHgwMDAwMDAwMAo5OS42MSAgIDQ0ODEgICAgNzEgICAgICAxMjQuOTIgIDEyNC4y
NSAgMHgwMDAwMDAwMAo1OS4zNSAgIDQ0NzkgICAgNDIgICAgICA3NS4wMyAgIDc0LjM3ICAgMHgw
MDAwMDAwMAowLjAwICAgIDQ4MDAgICAgNDIgICAgICAxLjM5ICAgIDAuNzMgICAgMHgwMDAwMDAw
MAowLjAwICAgIDQ4MDEgICAgNDIgICAgICAxLjQyICAgIDAuNzYgICAgMHgwMDAwMDAwMAoKYzAw
MDAwMAoKU2lnbmVkLW9mZi1ieTogRG91ZyBTbXl0aGllcyA8ZHNteXRoaWVzQHRlbHVzLm5ldD4K
U2lnbmVkLW9mZi1ieTogTGVuIEJyb3duIDxsZW4uYnJvd25AaW50ZWwuY29tPiAoc2ltcGxpZmll
ZCBEb3VnJ3MgcGF0Y2gpCi0tLQogdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQu
YyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5j
IGIvdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQuYwppbmRleCBjNWJkOWRlMjVh
YzcuLmVkNDM4NzJhZmNjMiAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90
dXJib3N0YXQuYworKysgYi90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jCkBA
IC0yNDU0LDkgKzI0NTQsMTAgQEAgaW50IHN1bV9jb3VudGVycyhzdHJ1Y3QgdGhyZWFkX2RhdGEg
KnQsIHN0cnVjdCBjb3JlX2RhdGEgKmMsIHN0cnVjdCBwa2dfZGF0YSAqcCkKIAlhdmVyYWdlLnBh
Y2thZ2VzLnJhcGxfZHJhbV9wZXJmX3N0YXR1cyArPSBwLT5yYXBsX2RyYW1fcGVyZl9zdGF0dXM7
CiAKIAlmb3IgKGkgPSAwLCBtcCA9IHN5cy5wcDsgbXA7IGkrKywgbXAgPSBtcC0+bmV4dCkgewot
CQlpZiAobXAtPmZvcm1hdCA9PSBGT1JNQVRfUkFXKQotCQkJY29udGludWU7Ci0JCWF2ZXJhZ2Uu
cGFja2FnZXMuY291bnRlcltpXSArPSBwLT5jb3VudGVyW2ldOworCQlpZiAoKG1wLT5mb3JtYXQg
PT0gRk9STUFUX1JBVykgJiYgKHRvcG8ubnVtX3BhY2thZ2VzID09IDApKQorCQkJYXZlcmFnZS5w
YWNrYWdlcy5jb3VudGVyW2ldID0gcC0+Y291bnRlcltpXTsKKwkJZWxzZQorCQkJYXZlcmFnZS5w
YWNrYWdlcy5jb3VudGVyW2ldICs9IHAtPmNvdW50ZXJbaV07CiAJfQogCXJldHVybiAwOwogfQot
LSAKMi4zOS4yCgo=
--00000000000010061f060b5482a3--

