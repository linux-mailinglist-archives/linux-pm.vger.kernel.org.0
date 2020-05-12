Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C41D1CF469
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgELMcN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:32:13 -0400
Received: from m177129.mail.qiye.163.com ([123.58.177.129]:17514 "EHLO
        m177129.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbgELMcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:32:13 -0400
Received: from vivo.com (wm-2.qy.internal [127.0.0.1])
        by m177129.mail.qiye.163.com (Hmail) with ESMTP id 3B81D5C342A;
        Tue, 12 May 2020 20:31:36 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AA*AkABhCGTIpJhY0Or0Saq5.3.1589286695947.Hmail.bernard@vivo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2Ml0gbWVtb3J5L3NhbXN1bmc6IHJlZHVjZSB1bm5lY2Vzc2FyeSBtdXRleCBsb2NrIGFyZWE=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <c910fa00-c27b-9854-9ab2-6f37c28b87f6@arm.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 12 May 2020 20:31:35 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Tue, 12 May 2020 20:31:35 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VLSU5LS0tLQk5ITUxPSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMTElPQk9ITUxMN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OlE6EDo5Ezg8LzILMRMiSzQJSygaCk5VSFVKTkNCSUNNTUJCSUJDVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT09CTDcG
X-HM-Tid: 0a7208de753a6447kurs3b81d5c342a
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CgpGcm9tOiBMdWthc3ogTHViYSA8bHVrYXN6Lmx1YmFAYXJtLmNvbT4KRGF0ZTogMjAyMC0wNS0x
MiAxOTo1Njo0OQpUbzogIE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+LEJl
cm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4sbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnLGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZyxsaW51eC1zYW1zdW5nLXNvY0B2Z2Vy
Lmtlcm5lbC5vcmcKQ2M6ICBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLG9wZW5zb3VyY2Uu
a2VybmVsQHZpdm8uY29tLEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4sS3Vr
amluIEtpbSA8a2dlbmVAa2VybmVsLm9yZz4KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbWVtb3J5
L3NhbXN1bmc6IHJlZHVjZSB1bm5lY2Vzc2FyeSBtdXRleCBsb2NrIGFyZWE+Cj4KPk9uIDUvMTIv
MjAgMTI6NDAgUE0sIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+Pj4gTWF5YmUgZG1jLT5kZi0+bG9j
ayBzZWVtcyBub3QgbmVlZGVkIHRvIHByb3RlY3QgImlmIChyZXQpCj4+PiAmIGRldl93YXJuIiBi
cmFuY2guIE1heWJlIHRoaXMgY2hhbmdlIHNwZWVkIHVwIHRoZSBjb2RlIGEgYml0Lgo+PiAKPj4g
SSBzdWdnZXN0IHRvIGltcHJvdmUgYWxzbyB0aGlzIGNvbW1pdCBtZXNzYWdlLgo+PiAKPj4gKiBQ
bGVhc2UgcmVkdWNlIHVuY2VydGFpbnR5Lgo+PiAKPj4gKiBBbiBpbXBlcmF0aXZlIHdvcmRpbmcg
aXMgcHJvYmFibHkgcHJlZmVycmVkLCBpc24ndCBpdD8KPj4gICAgaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9j
dW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aWQ9MTUyMDM2ZDEzNzlm
ZmQ2OTg1MjYyNzQzZGNmNmIwZjljNzVmODNhNCNuMTUxCj4+IAo+PiAqIFdpbGwgaXQgYmUgbW9y
ZSBhcHByb3ByaWF0ZSB0byByZWZlciB0byB0aGUgdHJhbnNmb3JtYXRpb24g4oCcUmVkdWNlIHRo
ZSBsb2NrIHNjb3Bl4oCdPwo+PiAKPj4gKiBXb3VsZCB5b3UgbGlrZSB0byBhZGQgdGhlIHRhZyDi
gJxGaXhlc+KAnSB0byB0aGUgY2hhbmdlIGRlc2NyaXB0aW9uPwo+PiAKPj4gUmVnYXJkcywKPj4g
TWFya3VzCj4+IAo+Cj5UaGFuayB5b3UgTWFya3VzIGZvciBwcm92aWRpbmcgdG8gQmVybmFyZCBo
ZWxwZnVsIHN1Z2dlc3Rpb25zLgo+Cj5AQmVybmFyZCBwbGVhc2UgcmVhZCB0aGUgbGluayBhYm92
ZSBhbmQgc2VuZCB2Mwo+Cj5Tb21ldGhpbmcgbGlrZTogJ21lbW9yeS9zYW1zdW5nOiByZWR1Y2Ug
cHJvdGVjdGVkIGNvZGUgYXJlYSBpbiBJUlEKPmhhbmRsZXInIGZvciB0aGUgc3ViamVjdCBoZWFk
ZXIgd291bGQgYmUgYmV0dGVyLgo+VGhlbiBpbiB0aGUgbWVzc2FnZSBleHBsYWluICh3aXRob3V0
ICdtYXliZScpIHRoYXQgaXQgd2lsbCBzcGVlZC11cCBhCj5iaXQgdGhpcyBJUlEgcHJvY2Vzc2lu
ZyBhbmQgdGhlcmUgaXMgbm8gbmVlZCB0byBwcm90ZWN0IHJldHVybiB2YWx1ZSBvcgo+cHJpbnRp
bmcuCj4KPlJlZ2FyZHMsCgo+THVrYXN6CgpTdXJlLCB0aGFuayB5b3UgYm90aCBNYXJrdXMgJiBM
dWthc3ogZm9yIHlvdXIgaGVscGZ1bCBzdWdnZXN0aW9ucywgSSB3aWxsIHJlYWQgdGhlIGNvbnRl
bnQKb2YgdGhlIGxpbmsgaW4gZGV0YWlsIGFuZCB1c2UgdGhhdCBwcmVmZXJyZWQgZm9ybWF0IGlu
IG15IGZ1dHVyZSBzdWJzZXF1ZW50IHN1Ym1pc3Npb25zLgoKUmVnYXJkcywKQmVybmFyZA0KDQo=
