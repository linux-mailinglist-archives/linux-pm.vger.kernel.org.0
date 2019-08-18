Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA791758
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfHROar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 10:30:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:59825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfHROar (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Aug 2019 10:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566138605;
        bh=hLYcToeezHf4hhXnjWzLCdKxM5gIK0icGM3XbjtZPHY=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=LgrhlsHHnrQ5D6dukHV9YUjrYL+t2YQqMc4Tawlbn/WGi4moyohaLXAM4rfZG86op
         N0fLGBd+G7erbyDkmIWN9VWzEWaDj1J2MwH+rz5cl8v3avLYO5MET8c/NsNEHuxxtS
         f1iIELB4GznxvEeaZOpqLDASVsB8m3cXPMcffHYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.197.41.87] ([80.187.106.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LeMWL-1ibiHB3r49-00q9Hg; Sun, 18
 Aug 2019 16:30:05 +0200
Date:   Sun, 18 Aug 2019 16:30:01 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190818135611.7776-1-frank-w@public-files.de>
References: <20190818135611.7776-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 00/13] implement poweroff for mt6323 / bpi-r2
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org
CC:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>, linux-pm@vger.kernel.org,
        Josef Friedl <josef.friedl@speed.at>,
        linux-kernel@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <B8BBF532-0642-4BB6-818B-4376E1E70431@public-files.de>
X-Provags-ID: V03:K1:zOBPsfR5VsRIKzVesxNFmJJSCrm0Fff6ZmF6d2IwO5U7qE4OrFU
 b5ps1PHdKlgJOkcsi8EW0pRYXPEi7BYynicsUWIvTDroCdJSlLJW/P6tVOwKU8aWtRGUjf/
 UBXtLWIcoEiyWdxHKY8T95xF9y7/TIhvqDfUzS3KbVRbpn7kEd5UGX4IuRSeaE8XZy+IPKy
 9yonCI0h9cZVNA6usR/BQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r0ruDgMvpM0=:ntuNEBZnKwg/0M0XUuunXI
 aMgls3M2XyuuBwgc3aXuM0XMXD65FwXYAUW/1cP834BllvVa/rNZhzgtyY3XrNOk9NJmTcMWB
 OW6WA8zLqutcBWQ+Utl563hVDtlxzjrTmbTz69U2uMu2La4mPHm5Icm2Kb6u27EzcQYkm4GXB
 ogs4cEjXHEsOqtElDTdmIqCC1jw75422kvotO2ZLdu9vw+P2JPSiQ/2r+p/B4wwE5/rWDZsjr
 mt8tBEkVL1UogwUIGAtkpcpOTlYbBTFZ4Hac3ZJgevC2J3LvaGcfSs2boXFepLZ4fcKSd/58G
 eWVlrO6xNX2pp+kV+erASbqmUwzVbBHA18Q3PVBJiBIB4NbgJbiTnu7jWjRzXuP51/zg3HTIO
 sYwXa9CYZcaGY2deMC6Galx4/s44gE6nidlNIWAEzmHoGPDpzxnZjEDQSLV+xl+NkYjdbhLe1
 8TvvFNMa5pdMa2CEz140FuQ4iCumSK/E+eaoMOpmifm/9gpKDMBqTKe6enSw6DdRvl73UPHbx
 syIwQpR0myvYJfNrcNHZtZ9325LiM4AuE5afyXvj0NG9BCarP/9IVbL5rOXxEPOpDGhxSmWo1
 0oRt1NSixNWZSb9Fc6rrAm4pZjut6QVSzHiZQLnMlf+Lx57BvCPGYMSN1+9KBOjJ0OROmqC2N
 aJ9lYXLPy6ISvk5ebnReKnxAdE2/YAIVIwYQ0lcD+RASDEuwGbHfbM0zqVDbacUzO1vSXTBR8
 9jI9xrPQ3xariQkni9HdCYrp3F6WnwjEFv1orPIcnoUrd+c02+KNp5lEHqrHjzz4iC2I7Q6eB
 yp9Y3vzPYztnXqTKPn8zENNIiwWMJLjd0k0VH50qjPFZMofBWYAeiE2xnXqT80HLXvYhL5rx1
 pNyg+nC5N/118Xhz7ik+pRfpec+mBZgLUqSkEaS61vTwxIrM/58JPZbG8zlwMafxnkXaoJYF/
 zQ3HBRTi0JWXuu27eEKrBK8sCfv+MsU3aY5G4KSdfAuoVU2ZweSydZ5z9MConAC5Z4Tb7jUhZ
 rJstYb5be3ik8NuGo8nOgFisd56yMYA3G5ItCY3hBiy3QEdQuTYU7WvArgosSyQS9J1MkGeks
 8A0CpD02P3L9wEd/kmbmum2LEuDoEOa2Kb6tNZcI8mmol56uCuB92R82CYchVEN5vVVth8xVl
 hTxqE=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Arg, missed a comma between

linux-arm-kernel@lists=2Einfradead=2Eorg
 and
Alessandro Zummo

Will send the series to linux-arm-kernel later

Sorry for that
