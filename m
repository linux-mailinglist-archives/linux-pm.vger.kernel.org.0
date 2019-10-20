Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2792DDE64
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfJTMSF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 08:18:05 -0400
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:44193
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbfJTMSE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 08:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571573881; bh=ZkSLcXkg1xPrFHtzBsy9ipALcIc7hyyhd9T7GsQ9zU4=; h=Date:From:Reply-To:Subject:From:Subject; b=bfWpeKHiILOE8atySBXezuq4QYJHZ8csu3yEqWkGWT/w+6bTBEFGuy+4LZe2f44EwkEb14Pexe6LqzvxME29T8KVMyzBmWtlF71lEI1aL9Q+3Z3qDj6RbCLWuy3CGRJbBlU7Yn6EDvsdQ7oCEzYWYXaATOhYT4wewViBAvNt6oKayw73WMagyXeq6Ok8iqA+EBssFpfGKpdQDua72b6nI/zcz7/dzCg4Wkb01Bpdt9tgBlapdS3aBLOkqtLuSoNpKmKvhIHVraumQ/FMLg31axMyu8QW/ErDOIV6tMjQxg3qdbDV0Wm0xkwfrhkF/3hmq1QED9cdFXGqMSVkyhOCEg==
X-YMail-OSG: W3nvcIoVM1mBvC0lvxx3FkeVQapwN37FdubumwLNddAEAtwyNmGqHuoopJymZrZ
 7K7k1Ji1lJGW7cpxM6pcpJWWAci.jqtEZBmsya2qrFZVShsmcnlHcTGWCBk.GYsFXrioYioLiNlM
 rUeEhzk9rmZR4xAwawsJrG0M5Axoge40THpPa2ZFpUalbLhEOnFMsE3qxD9qTHF.b4URaogMU9hf
 tP66x88czM0RgwbIKd361JCvVoWpf2bpegEQ0nQNZGM.qZNrQuKPW.tjhImcQQbUJZNOgwcZg0L7
 _K4A99rCdOTgtVww5uKEwFP_WigGuND3e9tURDKN1cmPxVxNFoih3p0xk3u0UBsz8Xf2qoaAiZBi
 eV_duRY_U3u6uPa06QlPx.1gWz2NWvIJrbfwlp_kEnMIumoWYaLWl6aWmyrChMEQ_XZkr_jJDZLs
 GmZ9Q7E2LNTT96ZSbnRE6jX.if444Xs76t8vPGdLTaVdTUSbqt32fIyyHxWp7B_DDGqlZnddtCyo
 4O26whPPxGQfh1Zf9nmHdgDZFetbC0hrGwromeO92vSgHnPSyqNQuwFmkzlVqsGhSsN4DuYrTPOZ
 FCN.ygdlfA1qiWWoKDfzca_vMNkQ_9H7IhXfLIZDXwK8J1ogNVxmiLRn2l2Uo0Y2YwJEgSvhwz0P
 1YPI2hWASW6q8nJwowz0R4vYMzwL1OPk62opVYI6OT5KiiCzno1QVdNXPuEAa7CkBMvMcmkjof7i
 KlPEoX7w978pWhUsHh6vZ9mNMj0u9de9mAQtI_b0kvLjdY.VGT.Ib5j9UJfHnNtk9_y6dYKgm9oY
 .gJ7nIZEHJ7NRNv8FcpRB21r6Z.9BaXtfIxvpxZb6OoHTQUwNFKth8PnWnwVCrS0haMxZpKitkKU
 yQn9VvyQerb24FdivYsdr_.QYX9ega_LSTePY6uAjilkWpR4MLF9CqPbfj0t8LFawHPR.dTgQ2bo
 vzHVn1VrBjVZfa.xPnS6gdLpOlGt.sGP3E7lBYo2nE6yKqf.2ziKZfsM73Y5oaBXaIJnhQlO_wuS
 apD3C6pCLo0hTYJDR6Fatok_.uUzxVjU8gYkm5c8n_WUqcmjnMHRigTHLdFb9hQptNXRdlQdXcex
 NNgH.YFJqoJuz_NQId5WZWrprds6BRP_815bn6kEqDn.u_wzd9ZnNn9eIgcuSu1FcWjbrkyi..kj
 eNYlviNXH_aN66ZtHgtLm9OOS_erbQpZ1uRLwcbUEHVXvHtT9BZtOPiSnOfA.YX53zUifhu16.BI
 yUMQLMKbIlH_yHCJPIYKXOd3TNdF5hgaeABhPLQGCR3au93aM9kmL3BFuBl8JUZjgEKV72bBIHrw
 kd8Sa562XqA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Sun, 20 Oct 2019 12:18:01 +0000
Date:   Sun, 20 Oct 2019 12:18:00 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1232844578.2721413.1571573880225@mail.yahoo.com>
Subject: BUSINESS CO-OPERATION CLAIM.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me forsuccess.

Note/ 50% for you why 50% for me after success of the transfer to your bank
account.

Below information is what i need from you so will can be reaching each
other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh.
