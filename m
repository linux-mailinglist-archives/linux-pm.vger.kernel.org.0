Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC68DB725C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 06:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfISEx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 00:53:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38141 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfISEx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 00:53:29 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190919045324epoutp01112fbd57e4f3e43012c277a11038be82~Fvd2oF5Hb2053520535epoutp01V
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 04:53:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190919045324epoutp01112fbd57e4f3e43012c277a11038be82~Fvd2oF5Hb2053520535epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568868804;
        bh=rWYsy+UNGlR5+0/eqBMs6htpuEB3LmWQnpGlPQZ6M9A=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Q2UT1pwI9vb3FmPQviv64iYoQtF2FRDgGWut+F951Jz8/IBBrDUE5f0gXrBKKRxx7
         NMfwxS9H51+j8q51I6Bx1mMbqOJBwn3qCOwCE6pyEFuxpchbWNtSegPEHEfv5c3FxV
         YC6hQ1UH/3PrcYQAOiwwJk27oNdX/IJmIQskzUnA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190919045324epcas1p3ef1fe78d8f0f35c70379c9a51a19fd2e~Fvd17j6CC2782027820epcas1p3R;
        Thu, 19 Sep 2019 04:53:24 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46Ykxr3VW1zMqYlp; Thu, 19 Sep
        2019 04:53:20 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-84-5d8309bb5e92
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.1F.04085.BB9038D5; Thu, 19 Sep 2019 13:53:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] devfreq: Make log message more explicit when devfreq
 device already exists
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190919000946.158454-1-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190919045314epcms1p178a5f45c964e53f28e55b9bf8ab11d28@epcms1p1>
Date:   Thu, 19 Sep 2019 13:53:14 +0900
X-CMS-MailID: 20190919045314epcms1p178a5f45c964e53f28e55b9bf8ab11d28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUiTcRju57fjmzj5NY9eLGx9oKSk26ctt8qotBhltEiiBFkf+jV1Z/um
        dLMsSeygw0jMK4qkpFudafSHWWFeRVkN84hu0gqnRIfZLtH/Hh6e533eiyQk//gRZK7JxlpN
        jIESBPIaH8TEx7WIDmXKT38WKV+NfeIruwqHhcrnzRUCpet4G1K6br5DK/nq8/ZnPPWJ+qtI
        7bodqSEy9MtzWCabtUpZU5Y5O9ekS6bWb9amaBVL5HQcrVImUVITY2STqdQ0TdzaXIM7kpIW
        MIZ8N6VhOI6SrVhuNefbWGmOmbMlU6wl22BRWeI5xsjlm3TxWWbjUlouT1C4hdv1OdcOnuVZ
        asldNXUTyI4KhSWIJAEvhreVBSVIREpwE4LrZUYPLcazYaIpxEOHYAZ6bl3h+yQU2J33CR8v
        g+KhRuTBAhwHDTf7eR4cihfC+z89bj6QJHAPgtejj70GwGIoO/KB58NzwVHb4DWLcBI4ijr9
        mjBw1o0Ip/D3R9XIh0OhaKDLr5kNQ79a0FSdstJJf8298PLcRaEnGPBhBMfrSv0iGXRWtgs8
        WIw3QPsLh9fAw1EwfLTPb06F3p+D3mACzwfHSAXhWQSBY+BGs8wnWQB3/1QinyQYvo0f40/N
        1VT1PsCHo6G15ZK//3nQce6Cv2c1uLr6BJ6SEnwAut6mnUTS8ulNl8/ILZ/OrUHEVRTOWjij
        juVoi2LmaW8j7+/FqprQo+60VoRJRAWJNbGFmRI+U8DtNrYiIAkqVFyhcFPibGb3HtZq1lrz
        DSzXihTu8U8REWFZZvcnm2xaWpGQmJioXEwvUdA0NUes1tkzJVjH2Fg9y1pY65QvgBRF2NGq
        FR9jZT9qd5ZUf4183NBXFX55WenTZQNbNMJtazNzx4NXRg5r9/zdKX2j2bGub6lInuEcXKRZ
        PeqE9N6U3+lP2DFVj7buzBr1xGTCvpCErVUPxzfKqvVDri8F0RndzgGx7eX+jhZBUHDx5L28
        vCB6U/jkai7Fead/sK2jPko1a4DicTkMHUtYOeY/4J6gdpEDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919000955epcas5p12bff9e26df88da7c0564d55081a0185b
References: <20190919000946.158454-1-mka@chromium.org>
        <CGME20190919000955epcas5p12bff9e26df88da7c0564d55081a0185b@epcms1p1>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>Before creating a new devfreq device devfreq_add_device() checks
>if there is already a devfreq dev associated with the requesting
>device (parent). If that's the case the function rejects to create
>another devfreq dev for that parent and logs an error. The error
>message is very unspecific, make it a bit more explicit.
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/devfreq.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index ab22bf8a12d6..0e2dd734ab58 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c
>@@ -625,7 +625,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> 	devfreq = find_device_devfreq(dev);
> 	mutex_unlock(&devfreq_list_lock);
> 	if (!IS_ERR(devfreq)) {
>-		dev_err(dev, "%s: Unable to create devfreq for the device.\n",
>+		dev_err(dev, "%s: devfreq device already exists!\n",

Yes, this is more helpful! Thanks!

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


