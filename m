Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10C7A3505
	for <lists+linux-pm@lfdr.de>; Sun, 17 Sep 2023 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjIQJwe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Sep 2023 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjIQJwS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Sep 2023 05:52:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474AF139
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694944330; x=1695549130; i=quwenruo.btrfs@gmx.com;
 bh=ngoqN74E0cXOFHPu40xUwwgTuhap9JEozUTNqKX9u+Y=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=UtMQU6DgunfUMu9vel9RCc2OqQ7ya6LcFcS2JmNMNA9vdbc+FHQmP97MQyoOSXz4Sp6591XJjKE
 +iUp0Z/OsoA0h+CggXf2u43nkJbEkI/85au1Zd2F+UvOptO5/JL+OwbZxNxoGSw/xyuottkeUHupX
 7CeSI3qodkfvaVtH3QTJktZSlFKGrBsetiPoyBLqvi33ELkkst5JMhSY9ynwPuMM57oWvE9x+yV49
 HSUSuuzA+kFOLU4hmCGtzdPMzj/sXxIJ32lDvJXHS9muQDTOZ42DG8Agx9nLvt4zsI8N/95XHEYLQ
 Gm3PoZnVBujn7fxfiR+I4zw7uZ53CBXcqVZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0oBr-1rbzZc1rGf-00wj1G; Sun, 17
 Sep 2023 11:52:10 +0200
Message-ID: <5b410ac7-ea26-4f26-96a0-84451943c83a@gmx.com>
Date:   Sun, 17 Sep 2023 19:22:06 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-pm@vger.kernel.org, ray.huang@amd.com
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Unable to disable AMD cpu boost using amd-pstate driver?
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:txS9Ti01rRN+q2xjWeZOUfTTqkp7Kk9uxdyNRojx2QxIaAVnXtM
 NhzPK8nBC9t8lfJQgAR4Rl5Ttwys1YRaNaAFjGIIMbHXXRwQ49UuGgW9AHpzMq+QNgpWfUk
 rNUBbbdpy+UGY7bQc60JbWIWQDQT3BQFyfO4z/Xvkm7Pjti/4TAywkx1Iljwups0g6X+BnF
 ZqG73/K5+I9AQ17ibw9FA==
UI-OutboundReport: notjunk:1;M01:P0:lQPGK6c5qXs=;z3rrqv60tT+Nl4wFF1vYlKA9Ydf
 XA5t5nonRw+JkpnfjgZCGVVplRQEdJRBLiNJT6N9/YjsZMQ/10xzuTrTuEiP6GbXdL+5LNHA4
 6TqCdjJE8DCBV6LWDsDDkQbD3AFvl3rzhWZEKo1/vLiCqoFjNVSQE+Pa3nH8RARlvEpiI/kbf
 I/vJc4z31QW+ETkpNxqMAjo17w2Qa5RLg+B1U6/FGIEVLPX3wATKU53nVq8pJzrWkdcp44jSB
 NTPY9thAASSyghwRBsU1mLOK+dtjAe4Ag5uwsTQaQc9pSg2/Hl5yDwepJpUvR4cmJpQEhenfe
 0hZdprEhylbAzVfeOdd90U3lmS5C56PJA4ulhzrA7o18iOYrhvempenxWDkMbAxUsXbo1KHiu
 /MPK0FRh7x3j6W60lSSdILk2nqCjwYLBk7JHuyMcHYhmuPmMsAk96ZK1ylcf7T1//sCtV1oJz
 ED4snBSSWBSzhmaWF/sHmhwlQNrtXqNq8mdTZuH5acYabDg1TgT1WvuKOPfHA6EWTn6hixZwx
 O5VY+7G/f3ITGHKSjQuEUvoUz/DXvuazCcQ4rctrnPq/zmb+sOR295eGZCpUXRutt5oKwTgB6
 8/js9pwJqpiuFp06v7Xt8cQSnpQnPQd+7vFQ7Oq13xZRCetyuVqfWWwwe5aQMqQDFD2eofKz5
 LvAKEu/fI+Fe0g30NqdTF7dnceOUTbgb7P6cUWJm3iMyH5lLCGUuV7w2/EBjXcgSBNmOVZDZH
 NI//icQ3nKxXs/e4dbM0w2AH1BBVTwRPCi1E4lP5HTa6l8XYxqWJwf6rx9QzU5qtrRMqODoVF
 fX/k8kZCNMG1Tp85tcY2aqRWJRv73zNp76LOvjhnw6Dh+kXe2z1GMRpWYtU7d7ScTaDnWbJLy
 WxQSnwD97+b+gz6+d5oOws5wLRXoBIVLneAPllGhJ/pvVNC6LLsRChLGZwOgC4rTD13gSsxBv
 PFTzquy2KFa+DfeCDjm2TorXSgU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui,

Thanks for your hard work maintaining amd-pstate driver first.

However it looks like if amd-pstate is used, there is no way to properly
disable the CPU boost (this becomes obvious especially in Linux 6.5, as
amd-pstate is enabled for my 7940HS CPU by default).

Previously using acpi-cppc, there is always a file named "boost" in
/sys/devices/system/cpu/cpufreq, and echo 0 into that file makes my CPU
temp never cross 75 during gaming sessions.


But in Linux 6.5, with amd-pstate, I have to go amd_state=3Dpassive to get
that file back, and echoing 0 into that file makes no difference.
I still easily got 90C during the same game.

For now I have to completely disable amd-pstate and rollback to acpi
driver to get a sane temperature.

Is there any proper way to disable the boost using amd-pstate?

Thanks,
Qu
