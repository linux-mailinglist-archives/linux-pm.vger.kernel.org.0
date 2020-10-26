Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6193298572
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 02:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421300AbgJZB6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 21:58:05 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:37989 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421299AbgJZB6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 21:58:05 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 625B11A16B5;
        Mon, 26 Oct 2020 09:49:24 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ANAAuADPDd5Q*8KfRTwcp4ps.1.1603676964376.Hmail.bernard@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: =?UTF-8?B?W1Jlc2VuZF1bUEFUQ0hdIGRyaXZlcnMvdGhlcm1hbDogb3B0aW1pemUgdGhlIGZvciBjaXJjbGUgdG8gcnVuIGEgYml0IGZhc3Q=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.124
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.124) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 26 Oct 2020 09:49:24 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Mon, 26 Oct 2020 09:49:24 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk9JGkoYS0IdQ05OVkpNS0hNTE1CTU9OSUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo1OjoOOj8rPx9OKlFDMB0pLwwY
        C08LCFVKVUpNS0hNTE1CTU5JSUhVMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWUpOTFVL
        VUhKVUpJT1lXWQgBWUFISkJJNwY+
X-HM-Tid: 0a756298864693b4kuws625b11a16b5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnVuY3Rpb24gdGhlcm1hbF96b25lX2RldmljZV9yZWdpc3RlciwgaW4gdGhlIGZvciBjaXJjbGUs
IGlmIHRoZQpmaXJzdCBpZiBicmFuY2ggc2V0IHRoZSBjb3VudCBiaXQgaW4gdHotPnRyaXBzX2Rp
c2FibGVkLCB0aGVyZSBpcwpubyBuZWVkIHRvIHNldCBpbiB0aGUgb3RoZXIgaWYgYnJhbmNoIGFn
YWluLgpUaGlzIGNoYW5nZSBpcyB0byBtYWtlIHRoZSBjb2RlIHJ1biBhIGJpdCBmYXN0IGFuZCBy
ZWFkYWJsZS4KClNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4K
LS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2Nv
cmUuYwppbmRleCBjNmQ3NGJjMWM5MGIuLjAzNTc3Nzk0ZWVhMyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy90aGVybWFsL3RoZXJtYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2Nv
cmUuYwpAQCAtMTQ0NiwxMCArMTQ0NiwxNCBAQCB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVy
KGNvbnN0IGNoYXIgKnR5cGUsIGludCB0cmlwcywgaW50IG1hc2ssCiAJCWdvdG8gcmVsZWFzZV9k
ZXZpY2U7CiAKIAlmb3IgKGNvdW50ID0gMDsgY291bnQgPCB0cmlwczsgY291bnQrKykgewotCQlp
ZiAodHotPm9wcy0+Z2V0X3RyaXBfdHlwZSh0eiwgY291bnQsICZ0cmlwX3R5cGUpKQorCQlpZiAo
dHotPm9wcy0+Z2V0X3RyaXBfdHlwZSh0eiwgY291bnQsICZ0cmlwX3R5cGUpKSB7CiAJCQlzZXRf
Yml0KGNvdW50LCAmdHotPnRyaXBzX2Rpc2FibGVkKTsKLQkJaWYgKHR6LT5vcHMtPmdldF90cmlw
X3RlbXAodHosIGNvdW50LCAmdHJpcF90ZW1wKSkKKwkJCWNvbnRpbnVlOworCQl9CisJCWlmICh0
ei0+b3BzLT5nZXRfdHJpcF90ZW1wKHR6LCBjb3VudCwgJnRyaXBfdGVtcCkpIHsKIAkJCXNldF9i
aXQoY291bnQsICZ0ei0+dHJpcHNfZGlzYWJsZWQpOworCQkJY29udGludWU7CisJCX0KIAkJLyog
Q2hlY2sgZm9yIGJvZ3VzIHRyaXAgcG9pbnRzICovCiAJCWlmICh0cmlwX3RlbXAgPT0gMCkKIAkJ
CXNldF9iaXQoY291bnQsICZ0ei0+dHJpcHNfZGlzYWJsZWQpOwotLSAKMi4yOC4wCgoNCg0K
