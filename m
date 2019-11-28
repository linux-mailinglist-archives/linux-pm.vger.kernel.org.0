Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1722110CA6D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfK1Ofl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:35:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46138 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfK1Ofl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:35:41 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so29117467iol.13;
        Thu, 28 Nov 2019 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ys0oMorfIi7C824w1iSly86fym9t4iyqfpjSyuy5/k0=;
        b=PioA0zCk+Zd1n1my8PwKcIy9bGLuGHvxzfRo+ZfAPyjeRq+t7owhwcYEMQIPTfrnqv
         EU+zFJ8MD/b9LESDZxyRZl+lq98TXlmoP3C/l3/7Yx/44I0GRpe1LHLi9k4z7UBseA4w
         Z4JmUD/WHtxFKrZ7HTsYtdtODVh1WugT0FZSoZyLM+RRL2sb5U1K8ZCuY70/n8frH34T
         N96cyOTf9JtCSEs6/uFNKga29ug5uOeOLvweU8aY2N2RzHXeKaESO32IKOpwhaKWuhr5
         MPyi3LMKkp2CfBjZH1Q70UelnV1rkoMhfNqfa2K8ERWEORXWWR4uYwVK/esOZq7LFZil
         kiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ys0oMorfIi7C824w1iSly86fym9t4iyqfpjSyuy5/k0=;
        b=ennCYRvfjdo7zYPj6kF5Nr5IDEj0x+K9lWIzIAZxzZ6caLOXtGJlJiJJr369Dr4a/t
         vIHDs831fNNoLjC4VxaWe+iWEDUe/H17tINeY1BDlyvOKqimagxgeeFj3qmMtFTjMmeZ
         47C2+h/3n+ii7m4zYVKE9e083LhQA5z35xWzLSe9SY65d3d/yKepteijwFKJRp/Cbwph
         lUEscjE1jQPtamWSB6q9XSE2MXhJ+np9LxgkCg5SaKB6KmWvzmE3VjqyOcG4iD0Qgewa
         uBaLRTrxJVeOEgPnR2nuMrFQrLaOWoqVoW18wjS5rcF7XWxNiVM88E8VploPIxisi9wD
         zV3Q==
X-Gm-Message-State: APjAAAUZf2B14Ayg7S/sq8rilH/zfahskC8NjsjoPmD512y1lxbeJdsX
        46jSaHx5e2E4SZqRkEggMxWR6PjQHr+n7h3rR6M=
X-Google-Smtp-Source: APXvYqyoGjY0mx1trgavH/ZA03bPvP02qQfLhuQ1bKJZqfjHvrQEWB4fK7mvLNy2ZuozIPH7DeV9tZeFX3KAwFGNV7c=
X-Received: by 2002:a5d:8953:: with SMTP id b19mr14362242iot.168.1574951738305;
 Thu, 28 Nov 2019 06:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-3-anarsoul@gmail.com>
 <20191127174434.wousbqosmm5vxcsu@gilmour.lan> <CA+E=qVe22T1uhUo6iq9a82Y9bC014CZSkAtSJJNX4qsn6dJL9w@mail.gmail.com>
 <20191128074325.q47rpzhufwog6mbb@gilmour.lan>
In-Reply-To: <20191128074325.q47rpzhufwog6mbb@gilmour.lan>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 28 Nov 2019 22:35:26 +0800
Message-ID: <CAEExFWs7A4TcB-QcatfR3w1hUX88dC-Sxd=epQppwB7p2CC6SA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e697a30598690697"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--000000000000e697a30598690697
Content-Type: text/plain; charset="UTF-8"

Hi,

How about this?

Best regards,
Yangtao

--000000000000e697a30598690697
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-dt-bindings-thermal-add-YAML-schema-for-sun8i-therma.patch"
Content-Disposition: attachment; 
	filename="0001-dt-bindings-thermal-add-YAML-schema-for-sun8i-therma.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k3itjtrt0>
X-Attachment-Id: f_k3itjtrt0

RnJvbSAzOGRkMGU0MTYyYjY5OGEzMDA3ZDRlZWU3NzFlMzQ4MTBkM2E4ZjlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYW5ndGFvIExpIDx0aW55LndpbmR6ekBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMjggTm92IDIwMTkgMjI6MzE6MjggKzA4MDAKU3ViamVjdDogW1BBVENIXSBkdC1i
aW5kaW5nczogdGhlcm1hbDogYWRkIFlBTUwgc2NoZW1hIGZvciBzdW44aS10aGVybWFsCiBkcml2
ZXIgYmluZGluZ3MKCnN1bjhpLXRoZXJtYWwgZHJpdmVyIHN1cHBvcnRzIHRoZXJtYWwgc2Vuc29y
IGluIHdpZGUgcmFuZ2Ugb2YgQWxsd2lubmVyClNvQ3MuIEFkZCBZQU1MIHNjaGVtYSBmb3IgaXRz
IGJpbmRpbmdzLgoKU2lnbmVkLW9mZi1ieTogWWFuZ3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwu
Y29tPgotLS0KIC4uLi9iaW5kaW5ncy90aGVybWFsL3N1bjhpLXRoZXJtYWwueWFtbCAgICAgICB8
IDE2MCArKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNjAgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aGVybWFsL3N1bjhpLXRoZXJtYWwueWFtbAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3N1bjhpLXRoZXJtYWwueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3N1bjhpLXRoZXJtYWwueWFtbApuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjFiZTMyZjA5ZmNjOAotLS0gL2Rldi9u
dWxsCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3N1bjhp
LXRoZXJtYWwueWFtbApAQCAtMCwwICsxLDE2MCBAQAorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMAorJVlBTUwgMS4yCistLS0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvdGhlcm1hbC9zdW44aS10aGVybWFsLnlhbWwjCiskc2NoZW1hOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMKKwordGl0bGU6IEFsbHdpbm5lciBTVU44
SSBUaGVybWFsIENvbnRyb2xsZXIgRGV2aWNlIFRyZWUgQmluZGluZ3MKKworbWFpbnRhaW5lcnM6
CisgIC0gWWFuZ3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwuY29tPgorCitkZXNjcmlwdGlvbjog
fC0KKyAgVGhpcyBkZXNjcmliZXMgdGhlIGRldmljZSB0cmVlIGJpbmRpbmcgZm9yIHRoZSBBbGx3
aW5uZXIgdGhlcm1hbAorICBjb250cm9sbGVyIHdoaWNoIG1lYXN1cmVzIHRoZSBvbi1Tb0MgdGVt
cGVyYXR1cmVzLgorCitwcm9wZXJ0aWVzOgorICBjb21wYXRpYmxlOgorICAgIGVudW06CisgICAg
ICAtIGFsbHdpbm5lcixzdW44aS1hODN0LXRocworICAgICAgLSBhbGx3aW5uZXIsc3VuOGktaDMt
dGhzCisgICAgICAtIGFsbHdpbm5lcixzdW44aS1yNDAtdGhzCisgICAgICAtIGFsbHdpbm5lcixz
dW41MGktYTY0LXRocworICAgICAgLSBhbGx3aW5uZXIsc3VuNTBpLWg1LXRocworICAgICAgLSBh
bGx3aW5uZXIsc3VuNTBpLWg2LXRocworCisgIHJlZzoKKyAgICBtYXhJdGVtczogMQorCisgIGlu
dGVycnVwdHM6CisgICAgbWF4SXRlbXM6IDEKKworICByZXNldHM6CisgICAgbWF4SXRlbXM6IDEK
KworICBjbG9ja3M6CisgICAgbWluSXRlbXM6IDEKKyAgICBtYXhJdGVtczogMgorICAgIGl0ZW1z
OgorICAgICAgLSBkZXNjcmlwdGlvbjogdGhzIGJ1cyBjbG9jaworICAgICAgLSBkZXNjcmlwdGlv
bjogdGhzIG1vZCBjbG9jaworCisgIGNsb2NrLW5hbWVzOgorICAgIG1pbkl0ZW1zOiAxCisgICAg
bWF4SXRlbXM6IDIKKyAgICBpdGVtczoKKyAgICAgIC0gY29uc3Q6IGJ1cworICAgICAgLSBjb25z
dDogbW9kCisKKyAgIiN0aGVybWFsLXNlbnNvci1jZWxscyI6CisgICAgZW51bTogWyAwLCAxIF0K
KworICBudm1lbS1jZWxsczoKKyAgICBkZXNjcmlwdGlvbjogdGhzIGNhbGlicmF0ZSBkYXRhCisK
KyAgbnZtZW0tY2VsbC1uYW1lczoKKyAgICBjb25zdDogY2FsaWJyYXRpb24KKworcmVxdWlyZWQ6
CisgIC0gY29tcGF0aWJsZQorICAtIHJlZworICAtIGludGVycnVwdHMKKyAgLSAiI3RoZXJtYWwt
c2Vuc29yLWNlbGxzIgorCithbGxPZjoKKyAgLSBpZjoKKyAgICAgIHByb3BlcnRpZXM6CisgICAg
ICAgIGNvbXBhdGlibGU6CisgICAgICAgICAgY29udGFpbnM6CisgICAgICAgICAgICBlbnVtOgor
ICAgICAgICAgICAgICAtIGFsbHdpbm5lcixzdW44aS1oMy10aHMKKyAgICAgICAgICAgICAgLSBh
bGx3aW5uZXIsc3VuOGktcjQwLXRocworICAgICAgICAgICAgICAtIGFsbHdpbm5lcixzdW41MGkt
YTY0LXRocworICAgICAgICAgICAgICAtIGFsbHdpbm5lcixzdW41MGktaDUtdGhzCisgICAgICAg
ICAgICAgIC0gYWxsd2lubmVyLHN1bjUwaS1oNi10aHMKKworICAgIHRoZW46CisgICAgICBwcm9w
ZXJ0aWVzOgorICAgICAgICByZXNldHM6CisgICAgICAgICAgbWluSXRlbXM6IDEKKyAgICAgICAg
ICBtYXhJdGVtczogMQorCisgIC0gaWY6CisgICAgICBwcm9wZXJ0aWVzOgorICAgICAgICBjb21w
YXRpYmxlOgorICAgICAgICAgIGNvbnRhaW5zOgorICAgICAgICAgICAgY29uc3Q6IGFsbHdpbm5l
cixzdW41MGktaDYtdGhzCisKKyAgICB0aGVuOgorICAgICAgcHJvcGVydGllczoKKyAgICAgICAg
Y2xvY2tzOgorICAgICAgICAgIG1pbkl0ZW1zOiAxCisgICAgICAgICAgbWF4SXRlbXM6IDEKKwor
ICAgICAgICBjbG9jay1uYW1lczoKKyAgICAgICAgICBtaW5JdGVtczogMQorICAgICAgICAgIG1h
eEl0ZW1zOiAxCisKKyAgICBlbHNlOgorICAgICAgaWY6CisgICAgICAgIHByb3BlcnRpZXM6Cisg
ICAgICAgICAgY29tcGF0aWJsZToKKyAgICAgICAgICAgIGNvbnRhaW5zOgorICAgICAgICAgICAg
ICBlbnVtOgorICAgICAgICAgICAgICAgIC0gYWxsd2lubmVyLHN1bjhpLWgzLXRocworICAgICAg
ICAgICAgICAgIC0gYWxsd2lubmVyLHN1bjhpLXI0MC10aHMKKyAgICAgICAgICAgICAgICAtIGFs
bHdpbm5lcixzdW41MGktYTY0LXRocworICAgICAgICAgICAgICAgIC0gYWxsd2lubmVyLHN1bjUw
aS1oNS10aHMKKworICAgICAgdGhlbjoKKyAgICAgICAgcHJvcGVydGllczoKKyAgICAgICAgICBj
bG9ja3M6CisgICAgICAgICAgICBtaW5JdGVtczogMgorICAgICAgICAgICAgbWF4SXRlbXM6IDIK
KworICAgICAgICAgIGNsb2NrLW5hbWVzOgorICAgICAgICAgICAgbWluSXRlbXM6IDIKKyAgICAg
ICAgICAgIG1heEl0ZW1zOiAyCisKKyAgLSBpZjoKKyAgICAgIHByb3BlcnRpZXM6CisgICAgICAg
IGNvbXBhdGlibGU6CisgICAgICAgICAgY29udGFpbnM6CisgICAgICAgICAgICBjb25zdDogYWxs
d2lubmVyLHN1bjhpLWgzLXRocworCisgICAgdGhlbjoKKyAgICAgIHByb3BlcnRpZXM6CisgICAg
ICAgICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiOgorICAgICAgICAgIGNvbnN0OiAwCisKKyAgICBl
bHNlOgorICAgICAgcHJvcGVydGllczoKKyAgICAgICAgIiN0aGVybWFsLXNlbnNvci1jZWxscyI6
CisgICAgICAgICAgY29uc3Q6IDEKKworYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlCisKK2V4
YW1wbGVzOgorICAtIHwKKyAgICB0aHM6IHRoc0A1MDcwNDAwIHsKKyAgICAgICAgY29tcGF0aWJs
ZSA9ICJhbGx3aW5uZXIsc3VuNTBpLWg2LXRocyI7CisgICAgICAgIHJlZyA9IDwweDA1MDcwNDAw
IDB4MTAwPjsKKyAgICAgICAgY2xvY2tzID0gPCZjY3UgODk+OworICAgICAgICBjbG9jay1uYW1l
cyA9ICJidXMiOworICAgICAgICByZXNldHMgPSA8JmNjdSAzNj47CisgICAgICAgIGludGVycnVw
dHMgPSA8MCAxNSA0PjsKKyAgICAgICAgbnZtZW0tY2VsbHMgPSA8JnRzZW5fY2FsaWI+OworICAg
ICAgICBudm1lbS1jZWxsLW5hbWVzID0gImNhbGlicmF0aW9uIjsKKyAgICAgICAgI3RoZXJtYWwt
c2Vuc29yLWNlbGxzID0gPDE+OworICAgIH07CisKKyAgICBzaWQ6IHNpZEAzMDA2MDAwIHsKKyAg
ICAgICAgY29tcGF0aWJsZSA9ICJhbGx3aW5uZXIsc3VuNTBpLWg2LXNpZCI7CisgICAgICAgIHJl
ZyA9IDwweDAzMDA2MDAwIDB4NDAwPjsKKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47Cisg
ICAgICAgICNzaXplLWNlbGxzID0gPDE+OworICAgICAgICB0c2VuX2NhbGliOiBjYWxpYkAxNCB7
CisgICAgICAgICAgICAgICAgcmVnID0gPDB4MTQgNj47CisgICAgICAgIH07CisgICAgfTsKKy4u
LgotLSAKMi4xNy4xCgo=
--000000000000e697a30598690697--
