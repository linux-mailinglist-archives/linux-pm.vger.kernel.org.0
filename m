Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5A1522FC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgBDXXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 18:23:39 -0500
Received: from sonic303-21.consmr.mail.ir2.yahoo.com ([77.238.178.202]:38464
        "EHLO sonic303-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbgBDXXj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 18:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580858617; bh=eg3qZapD09VJqj25AUJW5s1BYxWsWc1QdQQ9ZvAlPmk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PJ1zQCsa0B0ZHr2X9UHAvaWMGTJ6gGAz1PPbVoZgCKRncT1P2LGWmIbFbMnlz3Zsa9XZyEirpU4aDk9cGdFAuUbgULY3ylXvbYwtDL6PSEb0J38qAaxNo1TpAWp9DJtKeNL0DnEBGejWd0IqyAgceiT0zKZuZmdUdXlu61g7i8R3T7Q+wzyAvI8e+huyAgpaa8treTyokdY8cWXkO1YtTHr7lUN29C5jcz+ubm6nVWpDTosB0jHOSZ/mlebBn3F0TM7WZWpX/UB4w9ili4ZMokEbvbG11yY8pBu5zeeYZrXwMAYqsxB5Ho83LZPnb8X6E1RJFlNxfX/g80f1DVhp9g==
X-YMail-OSG: tl7B3uEVM1mlxULk6H7bhWnm_4iL3SL6Yfcieuz1atqoyWoI9xPNp2ayBBhsyqv
 NK2SDampif2eGJFJmoYKWflWn4v8jvqaG0gF4pCaVAHkXVbAcocEybR6u.fk1JFZxNyfTDERn_5E
 3k23v3pcIrsSVgkxoYPXaTruwXLYZvEQZNq3oVBugWYbJMPTNCpbsfOfzcS.S42F2QBB49YgaFS7
 tzM.dXpftyqSnU4l4Cl4fqQ5rRce9wwojHL1dy5TAJJgajc7rVemoQu8._kU5IkmRvKkuxRJAzbp
 QfsyaakIFzEXXRFmxlww1A0meOOcgYDvVSWF2WlzsTN48MppCsP7fYo3yUMJRLUaA7487Lodihul
 NX8On.ltVtp9CbhF0l56tH5RqSb9yLOmkTZRRPLMJ9deqy.uZAJdw5.GQJoKJvAQNmVMB4dRexwO
 g0tWMh_n3ztQYi6Z9VIM6LT4cjR2N5Yjkzk4Nt.P0eVrLlSL.cijSCJcui_ayvHjPUbiu0ireUZ8
 I5FHzw6ezRvpw.1PJQ1hRv9zHp_DMI.WOTMB4RDqMjhDcqKuCgdQXzo8JGowcEGZhiI8Ub9iBJnY
 5PAepPAEyKaa.tCUwcjAgi9.Q5Eateu4mVjPBNtBu6NZDs7Wu9TLZHkJPmAMaFJ03BHIO3CwVQeA
 uPCNkLMe4fZ0btsEb9o3SP5QIA.VJTGWZk8.PMsWGFq2FjYtBawi7BZFpbD_04oX0CjK.AsIF4nF
 7b3MLCFcNgqAeBs_wCeoZFUuqcVOEeW4tPG5SeoZalQBIXrctmWB8_Tb9A72EVSWbTBQE9xiyuds
 1Ye6swoqS2gG22o9FsoH_Omizi6i72b08Jzuu6oc1q3O3YmOnFxfzIgmeioDpurD3ihbMfmjRG3A
 9V6arcbM0M0sOOCsxZ3mWlv0AHEEXsUGLhZ2dF4fwdZxGxhP.sIxFlHavlRpsrHTkxCVhzIcoW2L
 askf_kJc8vhQ8jFWK9goT27TqEdvVnh3vzK25tyVKJPFqkJ0ICNYK9MgNzHm6aAWsSTFS7pgt3df
 zfQOCGEMzawGdSruLN1tA._84sC1liBME9t1K6lg.XsG01VZLq7CiK0VBzmqCu6qCUmkhObp2ZYS
 WdIRllDsFUjseqgavlO4OuFkWaTb4g4r6kR_xhCSoJFaGgyejBsjvzPoE2P6Kl0mC2llHROXGIau
 wAg.Ldrl0Pi7CwVWjlcuiNTPYGO8pn1vVXpm34dWbvvwgKHOYnL.PLj0UCUxgi1LIgLiWGThcLNp
 W7nYUojoawfz4tAW92QiookWbjlTOfKKK7TVZUi2alMjBTDm5sN0Ba3D7mdZbkvcDIekXJTHsMuB
 RHec-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 4 Feb 2020 23:23:37 +0000
Date:   Tue, 4 Feb 2020 23:23:36 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <599962984.986743.1580858616932@mail.yahoo.com>
Subject: BUSINESS TRANSFER CO-OPERATION.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <599962984.986743.1580858616932.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15158 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank,

Please i need your assistance for the transferring of this abandon (US$4.5M DOLLARS) to your bank account for both of us benefit.

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me after success.

Below information that is needed from you.

1)Private telephone number...
2)Age...
3)Nationality...
4)Occupation ...
5)Full Name....
Thanks.


Ms Lisa Hugh
