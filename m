Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9929BBF4
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2019 07:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfHXFVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Aug 2019 01:21:19 -0400
Received: from sonic317-34.consmr.mail.ne1.yahoo.com ([66.163.184.45]:38434
        "EHLO sonic317-34.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfHXFVT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Aug 2019 01:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1566624077; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=aw0Ixc+AmfosJMEhd+4EagO4Bw8bulxbjcQSV1+exzEtemodrTi6ghfR8MbivIPFIP67YTi+KE9NBO5lu4+JoqoQm9BwfN3lEyBVoP79u0skkV84L4BGb47KLxDXHHzMcxo5S96RipUClHjcPVHBo8Ke1GA4hrTrQoVsdeQPuQu5Y1EaU1KrIUluVT4MxmMNEVXxEVtgYdBLdCmf1KO/jAXxl0FFXkUFDix2jS98p9h5xavdgvrjHFtPlYml9EKRhCKvkkmuSBZqs3Ri9NWtQ+LAdaHITBnC8JLYeyWNJ+J3GvtgcfksEusK/yuxfD4tzQDREWUEM4PsSD6BTX8bWA==
X-YMail-OSG: XYv.0JcVM1nWFYJtvp40uLoGnYz5Rk43yEWKDy3q7i4EAG71Pr1IDPKI2EBRefE
 QSFbDsbB1q4ZI0qPWzFQ_hJ0t5JXV8.8xCKUyr1qy02eXh12AY0csGEKJiRnpvo8xTTkfM.UZsD.
 14js7XaVgKAcoLuOMJuUQx28jJQzZwDUczUHDwh1VHYNQIUqKa9v7OZMQMnFPRKjoR0s2g02UCQd
 ALbemEcNRpFr6nMfM3.GrWxNefWQeCvc8ge1U5rfg23utnklStwpm5tg5360uW9FSTaXm8qQW7BD
 kpZcQQ_6yo1kqYXry8Taoq_emz.hwIQ5s5mH8m4WDHil1lSOU.OexrMtwV5kv_Mna_ZS8vBAYlYY
 tfmxcdhKlR5hAbBXkAAQ9xvPs1v0ReXLtN.2w_94tgD9rCsG.pgOhUZ9CJA4P_dQWOU2j_LRoKks
 xGNJDuIUstVv5VaJFDwtnx8QB6kvJ0SE7zubhNln8EAMeU2BJSU4K4VTf6mUghlaXGENo79xlILE
 IMqP1Ym3HcXhzbW..hxZ_8wagT8YI3x8sUsW9BNwlRRR3s4bhihUGpYQHWNfItLk9NxcKj9gqchN
 G4SvqL3hN7uZE_MKb7RUZyh5uRDTs8LVgJZNwk2Wz6v3rphlyHPtJzcdqwTYAE0uVy3PzSUb6hkJ
 S5tWcF0r99aelM0C2rQoOHSZYkQ3KhNtP57UMY8DkN7_pO9ZeVNFsYIj9DKCCcJxoDEYlR5fsmEf
 BjTWvZ90IYBxI73YGqDc46ZJdRKHKXULAHih0tuTr.MbMyt6RuhAD2yWvy2RkneU5pCQPOgkD8qA
 MPvTYmiz7ix07wPBqakVDTKU4AQ1PxmbnPAa9M.cq8CuJfMOcZJHcdTaELXkAXFygyw0OlB1MZ5Z
 uxaYPw0OMYppw5unHoR1KNMdCrFb4QuF_JhJolFTWrl8WidShvk8T70L6SfCPdjgymIc1xG.JAdT
 zdR9UxI12mZp4unb66Y3qOh1W7ZixPJKW78Yt2ocsPt0ZQ5JC_iJxHlR5dHqzSfBxs6ZZbJSryFj
 xtAc117Je55N3Ths1_9sLNCT.RCxbKgVe4NJtuZWKPWaDfg16g2FZ9rBJLNd6THnH5xKB0c47Fvp
 AtTFrjl02uXcBZ22Hdo7BmMkZnwhPA5sEMfTEO8PNG0t2bpf9LUxxvp71n4flLuXz1hmfNY2_QHy
 sggS91YzeIL6H6gvrfumufeHiWXQ66kLjFW8dAB3Q.oTpY_sfMIg3S7K5gXVfMLf9olAJ.aINQ3E
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 24 Aug 2019 05:21:17 +0000
Date:   Sat, 24 Aug 2019 05:21:17 +0000 (UTC)
From:   Aisha Gaddafi <agaddafibb@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <962363774.2240742.1566624077010@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
