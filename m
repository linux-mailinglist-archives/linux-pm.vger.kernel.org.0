Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AFDAB8DF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405115AbfIFNHC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 09:07:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:57857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732510AbfIFNHC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Sep 2019 09:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567775184;
        bh=0OF9nooHaaz9QiSyWV5QXoHDrg/gupxebmNBl1oIx/g=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=i19y1XQ+Sjb3Bf6S8JT/ov4XiVViT4w3FmhmkXSFhxP1ExYkhhJh5xlnkxozMzdPM
         P/jf/5zVqMgnCM+ZJTXaIQfEy6GJvi3qWzmbPnthfVrnb79F3lpZgiWUo0Fb1Io/7i
         MI9+Sml/1ZkmccIktxdk6XvudYj+hZ+5PL3LP8lU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.17.198.103] ([80.187.119.108]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfC4q-1iUZHE1Ahk-00oo3Y; Fri, 06
 Sep 2019 15:06:24 +0200
Date:   Fri, 06 Sep 2019 15:06:19 +0200
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
Message-ID: <BB9183EF-A385-473B-A7D7-61D96499A291@public-files.de>
X-Provags-ID: V03:K1:V5jGArpFSoQO8rcBj/oQ7M7hCM+ph33LHPzlmTu2/Uz+Z+NoTcX
 mrjNJebj4twFmn5jbSeWp4bZPiW/10grqByIrn4WtPCQgOCLPpXEaJ2yGFdgw7i6E5BUstR
 PmB+0+7nZYeOikJPMidf6hjMitlyBSpljFZhNe1dJmHRpmpIxFDwyq26Z8gJSLVkTUkP345
 sigUEW/eA5FXNm5okGVWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LbUxFDSt/zk=:PJB+ZDjqw9jlHwGn0v8G+9
 ZoPPHWH6MdiweCHknS64vnRdhUSdAjXf2iNfRIxkJw/Wd9GGsqM2WFeltXxYoRLzbWs1Bf/ma
 t0Dxia/F/n4J39LCCmwCmOUR1z7II/VEuNpW2BH8tGbyq/TRXSY8DVL825VR1ldMhwbMI633Y
 p4kNR2U8011tsKhy70Z+3LXbkfQLmtT42pGZms01zWEoWm0adawZGytqFK+CziG19bKgzb4F5
 gjsweP9/ldVIUbBzlPV5/tYpUvvcdiTqwLKxMAACQQAn//hGZITZ5DJqk394LtxEzwXv1fRKX
 K77zFNi6jvITwa1drVRrZ5UKJjwXcyUdokLikgWtInMttdDl+vMw5VZszP0DkdAFXLWNgNwSj
 7g4tbsc8Z7annB6R0NXWXX1iYyJy/oN0gxneOfrmofD8yUNhHBITrMEoZ63RHw3xZ+1vW9tz5
 zM6MFCwEs9gja5EsoR5EKOzGl7zx/xawvxzaOnjlRF8qqBz/Aq6kdD3RHXYJyQHnDgjX+lPMo
 sbqVCvlI27Udtg2KZzViMnT8DvM+BTlAdP7d5/tJr9/wEYaTmrkkBFpOlQTX17xxOSHxtHDL8
 ZeN+N3nM+8Y0XqPLfoyj77ug9jQblhYJ4WQhlZ4F+b3ltJzKX6T6RLtfDfjTjHw1Brng7YVUs
 L7WY6TYOEaiSow4rT9ZRMsO7fbYsClxiAIxBtLPYxy1yY0z5aH1KVAGQOeyB1UkIpDENZzNUn
 6yDwSc602T5HwU4CSXILbA9GCgLK/9mi6TjoU7pXct4m1fe2OG1ODkTmHnTVFg4nz7j42262K
 UI+LtfGaufr8CDFFAr8dHUOuXpZqK7WATZgTAJ/miO5QtsyudWrnrAvbZMUV3CIsoqOD5FEKq
 Ok3P7JS/ZgEakHaXCM8OdKC68A3+VNdASSVzSQhNQzGDMf0nwkqBZVcQJCvuOVAcfTJPOFThX
 P5pye6mweyyWCnmCUF9koHbO0kR/1jayur2+9LEzO4xzN+9EFjlGAmRrssiuAzc0qFSkFLctC
 yx341pRqpYY5NmA585RnYd55lwz2IK0A0+wy3GdVOUEtQqOt8+Wlo0yuz78LR1NQE5p5nP6WP
 7ZfAkS2I7zrD7knwe8/lk3PX0Ug1UJkFk16VDj0a6tsivIwSRnvwZCR5IdxQASTEl+j8xoGUR
 jpzoro+p01afJHGmXRY9lugwG2PLTqd6O6QNwYjgkjtvEVnj0nCbywyHVeT5b1wjSgVYlR7TY
 B0mvQACDg7E77Exb0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Just a friedly reminder=2E

MFD-part was applied and visible in linux-next, the other parts acknowledg=
ed by maintainers=2E Is anything additional needed before applying the rtc/=
power/dts-parts?

Regards Frank
