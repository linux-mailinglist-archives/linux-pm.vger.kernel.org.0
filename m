Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA682AD0E3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKJIKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 03:10:54 -0500
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:57002 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJIKx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 03:10:53 -0500
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 9F51E1A3965;
        Tue, 10 Nov 2020 16:10:17 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AOUAJQBgDcHjy8iGeDq3e4rT.1.1604995817639.Hmail.bernard@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: =?UTF-8?B?W1Jlc2VuZF1bUEFUQ0hdIGRyaXZlcnMvdGhlcm1hbDogZml4IHBvdGVudGlhbCBtZW1sZWFrIGluIGVycm9yIGJyYW5jaA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.157
MIME-Version: 1.0
Received: from bernard@vivo.com( [58.213.83.157) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 10 Nov 2020 16:10:17 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Tue, 10 Nov 2020 16:10:17 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk5OH0kdH01JSEIeVkpNS09CQk5DSkxMTk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo0LjoxKjkcPxgzEQJDEjwePwpI
        Hk8JL1VKVUpNS09CQk5DSkNKTkhVMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWU5DVUlK
        SFVDSFVKTkxZV1kIAVlBSU5JQzcG
X-HM-Tid: 0a75b134a0c593b4kuws9f51e1a3965
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnVuY3Rpb24gX190aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3JlZ2lzdGVyLCB3aGVuIGRldmljZV9y
ZWdpc3RlcgpmYWlsZWQsIGNkZXYgaXMgbm90IGZyZWUgYWZ0ZXIgZXJyb3IgdmFsdWUgcmV0dXJu
LCB0aGlzIG1heQpicmluZyBpbiBwb3RlbnRpYWwgbWVtbGVhay4KClNpZ25lZC1vZmYtYnk6IEJl
cm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KLS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1h
bF9jb3JlLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyBiL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYwppbmRleCAzZDFlMDAzM2JmM2UuLmU0YmVlMTVkZmExZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYwpAQCAtMTEyNSw2ICsxMTI1LDcgQEAgX190aGVybWFsX2Nvb2xpbmdfZGV2aWNl
X3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsCiAJaWYgKHJlc3VsdCkgewogCQlpZGFf
c2ltcGxlX3JlbW92ZSgmdGhlcm1hbF9jZGV2X2lkYSwgY2Rldi0+aWQpOwogCQlwdXRfZGV2aWNl
KCZjZGV2LT5kZXZpY2UpOworCQlrZnJlZShjZGV2KTsKIAkJcmV0dXJuIEVSUl9QVFIocmVzdWx0
KTsKIAl9CiAKLS0gCjIuMjkuMAoKDQoNCg==
