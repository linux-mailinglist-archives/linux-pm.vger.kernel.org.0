Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DC46522D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 16:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350846AbhLAP7w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 10:59:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:51745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350986AbhLAP7w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Dec 2021 10:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638374190;
        bh=qQizQUwSZXDhRMLfD37oULKezH6m0NaTVPJYxHw4yGY=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=AOcHbkonrhE0ifToUjQzRkswOMJSWXfBZeIpD4tDakQn6SeaQqlMt0NIsw32Cgwhj
         yZofJm+/Ygqzjgq3+NuKvoYrONN4Gq9IRVF/GpIukXOH9af7fLbwdFB3oPqF3MdGtY
         PaGJ/28b+ySpGiHXL54p0GLqKg2pdgv2Wmr/9jkQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from flodo-tb13 ([37.5.248.227]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1n76AQ2pRr-00XpzL for
 <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 16:56:29 +0100
Date:   Wed, 1 Dec 2021 16:56:28 +0100
From:   Florian Dollinger <dollinger.florian@gmx.de>
To:     linux-pm <linux-pm@vger.kernel.org>
Message-ID: <BF9F1078-8789-42F6-92B8-CFC4A0A7895C@getmailspring.com>
Subject: Thinkbook 13s-IWL issues
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Provags-ID: V03:K1:Bo2/8ZBQO59wpxc2fJucySy1PnqHw0f4CcUeIvDRkO0uoU2IYrV
 minHdqSfuMMGoU1E+uH7DYxC6cD11XMRzYwKQRbjKE3/Nibqg/rfCNCx4M6o8NHFfQaFqWK
 aLUTiWBFeLaoDub+abXXSBfTLaieobY+VmFmiTrBokJvWAxcWXRfdQLGU5aJsLW3eNsA27q
 c1imIfx0Sa3EcrUv4EJTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/55+eTMtZTc=:sKndgKpPjMC3IZmSRC/X0O
 RpreRPmdOuPGRS0SBXpwL2JswgPvg3ZuWJeLaRdTzuZCMMh/SrOaQPYwVrbTj1BlI7evoDRKP
 UJzTIMllKNLYe1o+h760E+qE6HoLVFEifpzasjjbR9omvAfE382AUvYENe8o9CvibdElQjofJ
 zHAgsG/JWKm2KEiHMgBCUqHMtHEGJrYp+0M9dmo1EaiA2xyojsjn0qm2k4LXGjZXuuBC6lpIm
 NHeSHQMHGxtXCpFRX7jQsUoG9sO5KYBl2Kxwkax6PH2SE+gzRUkMqsvOAkGwBbiwcjCcbxbjM
 agTwaNpGsSOPT/80o45C/IhdESDodMsG4BiIAJt3bPTKCzx0eIFpxc2mEUauvRMT/pm2/q5pz
 Xf7gfROK5Jf2ISjwGAOxl+4w2G59r3TcIBHJbVUznryOxAEPFJmteide78BMqrycm8r52egKW
 8Q7mgFwdZEaxqiynysbsRy2AO2pFJdWtfn/K2MWuHC91Q7fP0vkop9mgQdBfPaanJbbj29Wyb
 mjPjstmT6hqIJcaztIjxuxLalhGTEF6nLYpX255c3yRw4i47OMZ8mG8PgcRWxUItH2m2NL//n
 dFW/Y4M1z1aK5duVL/0gv9dAOYTqPkUgVwLXN2ig+kTdrq5vbn4pIA0ta+0vk5uTCIsi1DlyI
 YhFTq13ukib2/Zt4It/D2rE+4FSds+Re0+67F+J18mByNGVeuM76LJxB1mzgRbihtRUpeXQ+/
 SD8XmIMWeojJ6aDnYLzW03jLqyzImv0pE0Mmh0sYHXEmO8DKbUeXiMUr5cXf2hVcRwIvbIZp1
 YrA5oRzh8DDsnOmiSSejq34v+Y6kiMs5hIsy/W/Rve7BStdKTWJm08lz67CzBNWMu/vHL+RVK
 133+E4qWLlPNehLM+2GmU7kTK5wZzrPutwERcxCoxPZkl24xjdaZYOc3krUldZ3svt5Soq0Gb
 DjSjgKzUlyuh2ctZHINv2V0x8jMA+bkpvq6LZ5hoM5N4yfIHl078w4qo0iQMZKvvEAPH95FBX
 evo2XoIoqxCAT3fg+u5Etg4LvrfbvPRjv2a3RusjHBEs03DoJR0v7EdU+yX6wbw7xUJaGczdW
 18F7zyrprb7wXo=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I am facing a rather weird issue on my Thinkbook 13s-IWL laptop. On an
arbitrary basis the device is trying to reach the suspend mode, but
after turning black the display it does not, as one would expect, turn
off the keyboard lights and starts flashing the power button. Instead it
reboots the system after a while. I am using the lastest UEFI version btw.

Anyway, I was able to find out the following:

* `pm-suspend` works flawlessly, I have tried a hundred times now and it
never crashed
* `systemctl suspend` instead, is crashing my system every once in a while

I would like to dig deeper there but I thought both commands do the same thing?
Looks like both are trying to reach the s2idle mode, right?

Thanks, Florian Dollinger

