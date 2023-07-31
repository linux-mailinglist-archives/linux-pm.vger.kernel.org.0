Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A7776A21C
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 22:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGaUmp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 16:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGaUmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 16:42:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A02390
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 13:42:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-790b9d7d643so2089239f.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690836161; x=1691440961;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XpCC3tOLTpKqE5XEEf3DLfZePXiAc1IjSgoBL2XtPGw=;
        b=WRRzui429GHkLB7+YIrBM+N33oWBU+/7iXSohevSKaXBZHTYwamKIBPJ4MI+hyLf3+
         FicbFwAez8loRGx5BdTVC1aTJNoAR4DBfCB4PibIpKgHhJXxVhE/NygkKL6BiBX3gmD+
         9Hi6te2RbNvj+MfmMGBmr+9cUlvAEPj2ftUsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690836161; x=1691440961;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpCC3tOLTpKqE5XEEf3DLfZePXiAc1IjSgoBL2XtPGw=;
        b=hJ7QYemDCYcmMj1odLqZ6+jZSTOlQYLLmlah5hzNopEVmVrrIUMfI8JVDrJTURS1ye
         Uc6jVJl6TJiq+yMxMuzNAk4NYBerQPPfdoN0RqtSFlXjYW33e7tD91lgBA/tRrGTYALw
         goRhxLa/aHi5Tx9B3czgWj85eX23FjvunIP6KaB38hdN/aO25/u9m1QlMIQ0bUeMU31K
         jI7p8+MxLsWpCFoDdTYWXOkbeapuesInZLHcd0ST9rxCn4Zc4O9VfrlTglCSzLnVKaOC
         LRvi+9n9W++SvBbuyy0nrRtXg6ED/wvRw2T/j8n5dSgduy8bNAR9SvTkzW73f4QuMX4I
         pY7g==
X-Gm-Message-State: ABy/qLb6Zp2eSI9EJyMih+4wKeuNgqc4fxWGGfHwAooHjJIwk3uQf2NK
        ttRT/MV0sQtA9xj2Hgj6eB5CZg==
X-Google-Smtp-Source: APBJJlGhIzafQwdOFz7b600+JmwJCPp7w4etPA7NDHpB/VFtLf3UNHRmjNX39xUOTZAh5hXlW+7Y2A==
X-Received: by 2002:a05:6602:3d5:b0:780:d65c:d78f with SMTP id g21-20020a05660203d500b00780d65cd78fmr12382748iov.2.1690836161368;
        Mon, 31 Jul 2023 13:42:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g22-20020a056602249600b0077e3acd5ea1sm3468552ioe.53.2023.07.31.13.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 13:42:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------yvlO0Yq00LgOZlfBA6ws29ia"
Message-ID: <bcce80ed-f2ef-a92f-f7b5-0b14f498d653@linuxfoundation.org>
Date:   Mon, 31 Jul 2023 14:42:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     trenn@suse.com, trenn@suse.de, linux-pm@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.6-rc1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------yvlO0Yq00LgOZlfBA6ws29ia
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.6-rc1.

This cpupower update for Linux 6.6-rc1 consists of 2 fixes and
enhancements to add support for amd-pstate active mode driver,
amd_pstate mode change, EPP value change, turbo-boost support,
and is_valid_path API.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.6-rc1

for you to fetch changes up to 99481d2195bfd13a663904e6014887abf46b57c7:

   cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation. (2023-07-18 16:07:08 -0600)

----------------------------------------------------------------
linux-cpupower-6.6-rc1

This cpupower update for Linux 6.6-rc1 consists of 2 fixes and
enhancements to add support for amd-pstate active mode driver,
amd_pstate mode change, EPP value change, turbo-boost support,
and is_valid_path API.

----------------------------------------------------------------
Ben Hutchings (1):
       cpupower: Bump soname version

Likhitha Korrapati (1):
       cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation.

Wyes Karny (5):
       cpupower: Recognise amd-pstate active mode driver
       cpupower: Add is_valid_path API
       cpupower: Add EPP value change support
       cpupower: Add support for amd_pstate mode change
       cpupower: Add turbo-boost support in cpupower

  tools/power/cpupower/Makefile                |  2 +-
  tools/power/cpupower/lib/cpupower.c          |  7 +++
  tools/power/cpupower/lib/cpupower_intern.h   |  1 +
  tools/power/cpupower/utils/cpuidle-set.c     | 16 +++----
  tools/power/cpupower/utils/cpupower-set.c    | 65 +++++++++++++++++++++++++++-
  tools/power/cpupower/utils/helpers/helpers.h | 11 +++++
  tools/power/cpupower/utils/helpers/misc.c    | 57 +++++++++++++++++++++++-
  7 files changed, 146 insertions(+), 13 deletions(-)
----------------------------------------------------------------
--------------yvlO0Yq00LgOZlfBA6ws29ia
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.6-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.6-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggNTliZmEwNWRlYzVkLi5kYzUzMTgwNWE1NzAg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC01Myw3ICs1Myw3IEBAIERFU1RESVIgPz0K
IAogVkVSU0lPTjo9CQkJJChzaGVsbCAuL3V0aWxzL3ZlcnNpb24tZ2VuLnNoKQogTElCX01B
Sj0JCQkwLjAuMQotTElCX01JTj0JCQkwCitMSUJfTUlOPQkJCTEKIAogUEFDS0FHRSA9CQkJ
Y3B1cG93ZXIKIFBBQ0tBR0VfQlVHUkVQT1JUID0JCWxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZwpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbGliL2NwdXBvd2VyLmMgYi90
b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1cG93ZXIuYwppbmRleCAzZjdkMGMwYzUwNjcu
LjdhMmVmNjkxYjIwZSAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbGliL2Nw
dXBvd2VyLmMKKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbGliL2NwdXBvd2VyLmMKQEAg
LTE0LDYgKzE0LDEzIEBACiAjaW5jbHVkZSAiY3B1cG93ZXIuaCIKICNpbmNsdWRlICJjcHVw
b3dlcl9pbnRlcm4uaCIKIAoraW50IGlzX3ZhbGlkX3BhdGgoY29uc3QgY2hhciAqcGF0aCkK
K3sKKwlpZiAoYWNjZXNzKHBhdGgsIEZfT0spID09IC0xKQorCQlyZXR1cm4gMDsKKwlyZXR1
cm4gMTsKK30KKwogdW5zaWduZWQgaW50IGNwdXBvd2VyX3JlYWRfc3lzZnMoY29uc3QgY2hh
ciAqcGF0aCwgY2hhciAqYnVmLCBzaXplX3QgYnVmbGVuKQogewogCXNzaXplX3QgbnVtcmVh
ZDsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVwb3dlcl9pbnRl
cm4uaCBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVwb3dlcl9pbnRlcm4uaAppbmRl
eCBhYzExMTJiOTU2ZWMuLjVmZGI4NjIwZDQxYiAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIv
Y3B1cG93ZXIvbGliL2NwdXBvd2VyX2ludGVybi5oCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBv
d2VyL2xpYi9jcHVwb3dlcl9pbnRlcm4uaApAQCAtNyw1ICs3LDYgQEAKIAogI2RlZmluZSBT
WVNGU19QQVRIX01BWCAyNTUKIAoraW50IGlzX3ZhbGlkX3BhdGgoY29uc3QgY2hhciAqcGF0
aCk7CiB1bnNpZ25lZCBpbnQgY3B1cG93ZXJfcmVhZF9zeXNmcyhjb25zdCBjaGFyICpwYXRo
LCBjaGFyICpidWYsIHNpemVfdCBidWZsZW4pOwogdW5zaWduZWQgaW50IGNwdXBvd2VyX3dy
aXRlX3N5c2ZzKGNvbnN0IGNoYXIgKnBhdGgsIGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1Zmxlbik7
CmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVpZGxlLXNldC5j
IGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1aWRsZS1zZXQuYwppbmRleCA0NjE1
ODkyOGY5YWQuLmE1NTFkMWQ0YWM1MSAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93
ZXIvdXRpbHMvY3B1aWRsZS1zZXQuYworKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGls
cy9jcHVpZGxlLXNldC5jCkBAIC00MSwxNCArNDEsNiBAQCBpbnQgY21kX2lkbGVfc2V0KGlu
dCBhcmdjLCBjaGFyICoqYXJndikKIAkJCWNvbnQgPSAwOwogCQkJYnJlYWs7CiAJCWNhc2Ug
J2QnOgotCQkJaWYgKHBhcmFtKSB7Ci0JCQkJcGFyYW0gPSAtMTsKLQkJCQljb250ID0gMDsK
LQkJCQlicmVhazsKLQkJCX0KLQkJCXBhcmFtID0gcmV0OwotCQkJaWRsZXN0YXRlID0gYXRv
aShvcHRhcmcpOwotCQkJYnJlYWs7CiAJCWNhc2UgJ2UnOgogCQkJaWYgKHBhcmFtKSB7CiAJ
CQkJcGFyYW0gPSAtMTsKQEAgLTU2LDcgKzQ4LDEzIEBAIGludCBjbWRfaWRsZV9zZXQoaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQogCQkJCWJyZWFrOwogCQkJfQogCQkJcGFyYW0gPSByZXQ7
Ci0JCQlpZGxlc3RhdGUgPSBhdG9pKG9wdGFyZyk7CisJCQlzdHJ0b2wob3B0YXJnLCAmZW5k
cHRyLCAxMCk7CisJCQlpZiAoKmVuZHB0ciAhPSAnXDAnKSB7CisJCQkJcHJpbnRmKF8oIkJh
ZCB2YWx1ZTogJXMsIEludGVnZXIgZXhwZWN0ZWRcbiIpLCBvcHRhcmcpOworCQkJCWV4aXQo
RVhJVF9GQUlMVVJFKTsKKwkJCX0gZWxzZSB7CisJCQkJaWRsZXN0YXRlID0gYXRvaShvcHRh
cmcpOworCQkJfQogCQkJYnJlYWs7CiAJCWNhc2UgJ0QnOgogCQkJaWYgKHBhcmFtKSB7CmRp
ZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVwb3dlci1zZXQuYyBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdXBvd2VyLXNldC5jCmluZGV4IDE4MGQ1
YmE4NzdlNi4uMDY3N2I1ODM3NGFiIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dl
ci91dGlscy9jcHVwb3dlci1zZXQuYworKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGls
cy9jcHVwb3dlci1zZXQuYwpAQCAtMTgsNiArMTgsOSBAQAogCiBzdGF0aWMgc3RydWN0IG9w
dGlvbiBzZXRfb3B0c1tdID0gewogCXsicGVyZi1iaWFzIiwgcmVxdWlyZWRfYXJndW1lbnQs
IE5VTEwsICdiJ30sCisJeyJlcHAiLCByZXF1aXJlZF9hcmd1bWVudCwgTlVMTCwgJ2UnfSwK
Kwl7ImFtZC1wc3RhdGUtbW9kZSIsIHJlcXVpcmVkX2FyZ3VtZW50LCBOVUxMLCAnbSd9LAor
CXsidHVyYm8tYm9vc3QiLCByZXF1aXJlZF9hcmd1bWVudCwgTlVMTCwgJ3QnfSwKIAl7IH0s
CiB9OwogCkBAIC0zNywxMSArNDAsMTUgQEAgaW50IGNtZF9zZXQoaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQogCXVuaW9uIHsKIAkJc3RydWN0IHsKIAkJCWludCBwZXJmX2JpYXM6MTsKKwkJ
CWludCBlcHA6MTsKKwkJCWludCBtb2RlOjE7CisJCQlpbnQgdHVyYm9fYm9vc3Q6MTsKIAkJ
fTsKIAkJaW50IHBhcmFtczsKIAl9IHBhcmFtczsKLQlpbnQgcGVyZl9iaWFzID0gMDsKKwlp
bnQgcGVyZl9iaWFzID0gMCwgdHVyYm9fYm9vc3QgPSAxOwogCWludCByZXQgPSAwOworCWNo
YXIgZXBwWzMwXSwgbW9kZVsyMF07CiAKIAlyZXQgPSB1bmFtZSgmdXRzKTsKIAlpZiAoIXJl
dCAmJiAoIXN0cmNtcCh1dHMubWFjaGluZSwgInBwYzY0bGUiKSB8fApAQCAtNTUsNyArNjIs
NyBAQCBpbnQgY21kX3NldChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAKIAlwYXJhbXMucGFy
YW1zID0gMDsKIAkvKiBwYXJhbWV0ZXIgcGFyc2luZyAqLwotCXdoaWxlICgocmV0ID0gZ2V0
b3B0X2xvbmcoYXJnYywgYXJndiwgImI6IiwKKwl3aGlsZSAoKHJldCA9IGdldG9wdF9sb25n
KGFyZ2MsIGFyZ3YsICJiOmU6bToiLAogCQkJCQkJc2V0X29wdHMsIE5VTEwpKSAhPSAtMSkg
ewogCQlzd2l0Y2ggKHJldCkgewogCQljYXNlICdiJzoKQEAgLTY5LDYgKzc2LDM4IEBAIGlu
dCBjbWRfc2V0KGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJCX0KIAkJCXBhcmFtcy5wZXJm
X2JpYXMgPSAxOwogCQkJYnJlYWs7CisJCWNhc2UgJ2UnOgorCQkJaWYgKHBhcmFtcy5lcHAp
CisJCQkJcHJpbnRfd3JvbmdfYXJnX2V4aXQoKTsKKwkJCWlmIChzc2NhbmYob3B0YXJnLCAi
JTI5cyIsIGVwcCkgIT0gMSkgeworCQkJCXByaW50X3dyb25nX2FyZ19leGl0KCk7CisJCQkJ
cmV0dXJuIC1FSU5WQUw7CisJCQl9CisJCQlwYXJhbXMuZXBwID0gMTsKKwkJCWJyZWFrOwor
CQljYXNlICdtJzoKKwkJCWlmIChjcHVwb3dlcl9jcHVfaW5mby52ZW5kb3IgIT0gWDg2X1ZF
TkRPUl9BTUQpCisJCQkJcHJpbnRfd3JvbmdfYXJnX2V4aXQoKTsKKwkJCWlmIChwYXJhbXMu
bW9kZSkKKwkJCQlwcmludF93cm9uZ19hcmdfZXhpdCgpOworCQkJaWYgKHNzY2FuZihvcHRh
cmcsICIlMTlzIiwgbW9kZSkgIT0gMSkgeworCQkJCXByaW50X3dyb25nX2FyZ19leGl0KCk7
CisJCQkJcmV0dXJuIC1FSU5WQUw7CisJCQl9CisJCQlwYXJhbXMubW9kZSA9IDE7CisJCQli
cmVhazsKKwkJY2FzZSAndCc6CisJCQlpZiAocGFyYW1zLnR1cmJvX2Jvb3N0KQorCQkJCXBy
aW50X3dyb25nX2FyZ19leGl0KCk7CisJCQl0dXJib19ib29zdCA9IGF0b2kob3B0YXJnKTsK
KwkJCWlmICh0dXJib19ib29zdCA8IDAgfHwgdHVyYm9fYm9vc3QgPiAxKSB7CisJCQkJcHJp
bnRmKCItLXR1cmJvLWJvb3N0IHBhcmFtIG91dCBvZiByYW5nZSBbMC0xXVxuIik7CisJCQkJ
cHJpbnRfd3JvbmdfYXJnX2V4aXQoKTsKKwkJCX0KKwkJCXBhcmFtcy50dXJib19ib29zdCA9
IDE7CisJCQlicmVhazsKKworCiAJCWRlZmF1bHQ6CiAJCQlwcmludF93cm9uZ19hcmdfZXhp
dCgpOwogCQl9CkBAIC03Nyw2ICsxMTYsMTggQEAgaW50IGNtZF9zZXQoaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQogCWlmICghcGFyYW1zLnBhcmFtcykKIAkJcHJpbnRfd3JvbmdfYXJnX2V4
aXQoKTsKIAorCWlmIChwYXJhbXMubW9kZSkgeworCQlyZXQgPSBjcHVwb3dlcl9zZXRfYW1k
X3BzdGF0ZV9tb2RlKG1vZGUpOworCQlpZiAocmV0KQorCQkJZnByaW50ZihzdGRlcnIsICJF
cnJvciBzZXR0aW5nIG1vZGVcbiIpOworCX0KKworCWlmIChwYXJhbXMudHVyYm9fYm9vc3Qp
IHsKKwkJcmV0ID0gY3B1cG93ZXJfc2V0X3R1cmJvX2Jvb3N0KHR1cmJvX2Jvb3N0KTsKKwkJ
aWYgKHJldCkKKwkJCWZwcmludGYoc3RkZXJyLCAiRXJyb3Igc2V0dGluZyB0dXJiby1ib29z
dFxuIik7CisJfQorCiAJLyogRGVmYXVsdCBpczogc2V0IGFsbCBDUFVzICovCiAJaWYgKGJp
dG1hc2tfaXNhbGxjbGVhcihjcHVzX2Nob3NlbikpCiAJCWJpdG1hc2tfc2V0YWxsKGNwdXNf
Y2hvc2VuKTsKQEAgLTEwMiw2ICsxNTMsMTYgQEAgaW50IGNtZF9zZXQoaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQogCQkJCWJyZWFrOwogCQkJfQogCQl9CisKKwkJaWYgKHBhcmFtcy5lcHAp
IHsKKwkJCXJldCA9IGNwdXBvd2VyX3NldF9lcHAoY3B1LCBlcHApOworCQkJaWYgKHJldCkg
eworCQkJCWZwcmludGYoc3RkZXJyLAorCQkJCQkiRXJyb3Igc2V0dGluZyBlcHAgdmFsdWUg
b24gQ1BVICVkXG4iLCBjcHUpOworCQkJCWJyZWFrOworCQkJfQorCQl9CisKIAl9CiAJcmV0
dXJuIHJldDsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hl
bHBlcnMvaGVscGVycy5oIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9o
ZWxwZXJzLmgKaW5kZXggOTZlNGJlZGUwNzhiLi45NTc0OWI4ZWU0NzUgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvaGVscGVycy5oCisrKyBiL3Rv
b2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvaGVscGVycy5oCkBAIC0xMTYsNiAr
MTE2LDEwIEBAIGV4dGVybiBpbnQgY3B1cG93ZXJfaW50ZWxfc2V0X3BlcmZfYmlhcyh1bnNp
Z25lZCBpbnQgY3B1LCB1bnNpZ25lZCBpbnQgdmFsKTsKIGV4dGVybiBpbnQgY3B1cG93ZXJf
aW50ZWxfZ2V0X3BlcmZfYmlhcyh1bnNpZ25lZCBpbnQgY3B1KTsKIGV4dGVybiB1bnNpZ25l
ZCBsb25nIGxvbmcgbXNyX2ludGVsX2dldF90dXJib19yYXRpbyh1bnNpZ25lZCBpbnQgY3B1
KTsKIAorZXh0ZXJuIGludCBjcHVwb3dlcl9zZXRfZXBwKHVuc2lnbmVkIGludCBjcHUsIGNo
YXIgKmVwcCk7CitleHRlcm4gaW50IGNwdXBvd2VyX3NldF9hbWRfcHN0YXRlX21vZGUoY2hh
ciAqbW9kZSk7CitleHRlcm4gaW50IGNwdXBvd2VyX3NldF90dXJib19ib29zdChpbnQgdHVy
Ym9fYm9vc3QpOworCiAvKiBSZWFkL1dyaXRlIG1zciAqKioqKioqKioqKioqKioqKioqKioq
KioqKioqLwogCiAvKiBQQ0kgc3R1ZmYgKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8K
QEAgLTE3Myw2ICsxNzcsMTMgQEAgc3RhdGljIGlubGluZSBpbnQgY3B1cG93ZXJfaW50ZWxf
Z2V0X3BlcmZfYmlhcyh1bnNpZ25lZCBpbnQgY3B1KQogc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIGxvbmcgbXNyX2ludGVsX2dldF90dXJib19yYXRpbyh1bnNpZ25lZCBpbnQgY3B1
KQogeyByZXR1cm4gMDsgfTsKIAorc3RhdGljIGlubGluZSBpbnQgY3B1cG93ZXJfc2V0X2Vw
cCh1bnNpZ25lZCBpbnQgY3B1LCBjaGFyICplcHApCit7IHJldHVybiAtMTsgfTsKK3N0YXRp
YyBpbmxpbmUgaW50IGNwdXBvd2VyX3NldF9hbWRfcHN0YXRlX21vZGUoY2hhciAqbW9kZSkK
K3sgcmV0dXJuIC0xOyB9Oworc3RhdGljIGlubGluZSBpbnQgY3B1cG93ZXJfc2V0X3R1cmJv
X2Jvb3N0KGludCB0dXJib19ib29zdCkKK3sgcmV0dXJuIC0xOyB9OworCiAvKiBSZWFkL1dy
aXRlIG1zciAqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogCiBzdGF0aWMgaW5saW5l
IGludCBjcHVmcmVxX2hhc19ib29zdF9zdXBwb3J0KHVuc2lnbmVkIGludCBjcHUsIGludCAq
c3VwcG9ydCwKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBl
cnMvbWlzYy5jIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9taXNjLmMK
aW5kZXggOTU0N2IyOTI1NGE3Li43NmU0NjFmZjRmNzQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bv
d2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvbWlzYy5jCisrKyBiL3Rvb2xzL3Bvd2VyL2Nw
dXBvd2VyL3V0aWxzL2hlbHBlcnMvbWlzYy5jCkBAIC04Nyw2ICs4Nyw2MSBAQCBpbnQgY3B1
cG93ZXJfaW50ZWxfc2V0X3BlcmZfYmlhcyh1bnNpZ25lZCBpbnQgY3B1LCB1bnNpZ25lZCBp
bnQgdmFsKQogCXJldHVybiAwOwogfQogCitpbnQgY3B1cG93ZXJfc2V0X2VwcCh1bnNpZ25l
ZCBpbnQgY3B1LCBjaGFyICplcHApCit7CisJY2hhciBwYXRoW1NZU0ZTX1BBVEhfTUFYXTsK
KwljaGFyIGxpbmVidWZbMzBdID0ge307CisKKwlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0
aCksCisJCVBBVEhfVE9fQ1BVICJjcHUldS9jcHVmcmVxL2VuZXJneV9wZXJmb3JtYW5jZV9w
cmVmZXJlbmNlIiwgY3B1KTsKKworCWlmICghaXNfdmFsaWRfcGF0aChwYXRoKSkKKwkJcmV0
dXJuIC0xOworCisJc25wcmludGYobGluZWJ1Ziwgc2l6ZW9mKGxpbmVidWYpLCAiJXMiLCBl
cHApOworCisJaWYgKGNwdXBvd2VyX3dyaXRlX3N5c2ZzKHBhdGgsIGxpbmVidWYsIDMwKSA8
PSAwKQorCQlyZXR1cm4gLTE7CisKKwlyZXR1cm4gMDsKK30KKworaW50IGNwdXBvd2VyX3Nl
dF9hbWRfcHN0YXRlX21vZGUoY2hhciAqbW9kZSkKK3sKKwljaGFyIHBhdGhbU1lTRlNfUEFU
SF9NQVhdOworCWNoYXIgbGluZWJ1ZlsyMF0gPSB7fTsKKworCXNucHJpbnRmKHBhdGgsIHNp
emVvZihwYXRoKSwgUEFUSF9UT19DUFUgImFtZF9wc3RhdGUvc3RhdHVzIik7CisKKwlpZiAo
IWlzX3ZhbGlkX3BhdGgocGF0aCkpCisJCXJldHVybiAtMTsKKworCXNucHJpbnRmKGxpbmVi
dWYsIHNpemVvZihsaW5lYnVmKSwgIiVzXG4iLCBtb2RlKTsKKworCWlmIChjcHVwb3dlcl93
cml0ZV9zeXNmcyhwYXRoLCBsaW5lYnVmLCAyMCkgPD0gMCkKKwkJcmV0dXJuIC0xOworCisJ
cmV0dXJuIDA7Cit9CisKK2ludCBjcHVwb3dlcl9zZXRfdHVyYm9fYm9vc3QoaW50IHR1cmJv
X2Jvb3N0KQoreworCWNoYXIgcGF0aFtTWVNGU19QQVRIX01BWF07CisJY2hhciBsaW5lYnVm
WzJdID0ge307CisKKwlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksIFBBVEhfVE9fQ1BV
ICJjcHVmcmVxL2Jvb3N0Iik7CisKKwlpZiAoIWlzX3ZhbGlkX3BhdGgocGF0aCkpCisJCXJl
dHVybiAtMTsKKworCXNucHJpbnRmKGxpbmVidWYsIHNpemVvZihsaW5lYnVmKSwgIiVkIiwg
dHVyYm9fYm9vc3QpOworCisJaWYgKGNwdXBvd2VyX3dyaXRlX3N5c2ZzKHBhdGgsIGxpbmVi
dWYsIDIpIDw9IDApCisJCXJldHVybiAtMTsKKworCXJldHVybiAwOworfQorCiBib29sIGNw
dXBvd2VyX2FtZF9wc3RhdGVfZW5hYmxlZCh2b2lkKQogewogCWNoYXIgKmRyaXZlciA9IGNw
dWZyZXFfZ2V0X2RyaXZlcigwKTsKQEAgLTk1LDcgKzE1MCw3IEBAIGJvb2wgY3B1cG93ZXJf
YW1kX3BzdGF0ZV9lbmFibGVkKHZvaWQpCiAJaWYgKCFkcml2ZXIpCiAJCXJldHVybiByZXQ7
CiAKLQlpZiAoIXN0cmNtcChkcml2ZXIsICJhbWQtcHN0YXRlIikpCisJaWYgKCFzdHJuY21w
KGRyaXZlciwgImFtZCIsIDMpKQogCQlyZXQgPSB0cnVlOwogCiAJY3B1ZnJlcV9wdXRfZHJp
dmVyKGRyaXZlcik7Cg==

--------------yvlO0Yq00LgOZlfBA6ws29ia--
