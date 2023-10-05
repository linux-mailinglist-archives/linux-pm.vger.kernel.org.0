Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469CE7B99FA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 04:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJEChQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJEChP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 22:37:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ACCBF;
        Wed,  4 Oct 2023 19:37:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950bjP5023885;
        Thu, 5 Oct 2023 02:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=V27n8ft8nsVqh5GI5hHlJjtYIbWHRuSN/i9MdrBOTEk=;
 b=KZVPJpXROpIVTZFIYie6P++TPDsvFRcASegfDP8Cmsfdvgv9zYu6ZkPeE9Uk2mterNKA
 nl4RGc+bOCfAQ3RE0TgUfJmjJshS7yx3oJ1oQTHEsRRmv2jm+9jjTYHfK+vMfW2Feel1
 Zsh7GeQvBULVKKW3NwA4IypesfTkNHInKBR2b2otYKOio0KeVqXaMU6ASGNOKKtspbqs
 STVQJSoWwhu5sqDNMJ6+Q/ykRkxwYK3Z+8UWXoHMfBmWU31DXyk3jKUtmibuO09JY6ph
 sjn6QAcZixwxguSisHe+U2CfYpUUddCT+aPeSfT2sBJlWKXCXGS/adYqLAlnLt2M860T Vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8ck1sv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 02:37:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3952axRH012106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 02:36:59 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 4 Oct 2023 19:36:59 -0700
Date:   Wed, 4 Oct 2023 19:36:58 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Thara Gopinath" <thara.gopinath@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation
 Device support
Message-ID: <20231005023658.GE3553829@hu-bjorande-lv.qualcomm.com>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20231001155701.GA53767@thinkpad>
 <cefe711b-d274-4d83-9dda-01f33b342387@linaro.org>
 <20231002145239.GA12041@thinkpad>
 <CAA8EJppn-f6R3ObGvagqkg1_KtXGgtNAgRn-LQiN3ORSHQY3-Q@mail.gmail.com>
 <20231002155814.GB12041@thinkpad>
 <CAA8EJpowGjnecOjr9h4r3=UXSrE4VdptoLADpQq3gDv_W9D3OQ@mail.gmail.com>
 <20231002161308.GC12041@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231002161308.GC12041@thinkpad>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eWDIjXeBkRwL2ihq6FCFL_HxlZVgtxAq
X-Proofpoint-ORIG-GUID: eWDIjXeBkRwL2ihq6FCFL_HxlZVgtxAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310050020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 02, 2023 at 09:43:08PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 02, 2023 at 07:00:27PM +0300, Dmitry Baryshkov wrote:
> > On Mon, 2 Oct 2023 at 18:58, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > >
> > > On Mon, Oct 02, 2023 at 06:00:37PM +0300, Dmitry Baryshkov wrote:
> > > > On Mon, 2 Oct 2023 at 17:52, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > >
> > > > > On Sun, Oct 01, 2023 at 06:26:14PM +0100, Caleb Connolly wrote:
> > > > > >
> > > > > >
> > > > > > On 01/10/2023 16:57, Manivannan Sadhasivam wrote:
> > > > > > > On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
> > > > > > > > The Thermal Mitigation Device (TMD) Service is a QMI service that runs
> > > > > > > > on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
> > > > > > > > It exposes various mitigations including passive thermal controls and
> > > > > > > > rail voltage restrictions.
> > > > > > > >
> > > > > > > > This series introduces support for exposing TMDs as cooling devices
> > > > > > > > in the kernel through the thermal framework, using the QMI interface.
> > > > > > > >
> > > > > > > > Each TMD client is described as a child of the remoteproc node in
> > > > > > > > devicetree. With subnodes for each control.
> > > > > > > >
> > > > > > >
> > > > > > > Daniel expressed concerns in the past aganist representing TMD driver as a
> > > > > > > cooling device since it is not tied to thermal zones and the governors cannot
> > > > > > > use it. Instead he suggested to represent it as a powercap device with thermal
> > > > > > > constraints.
> > > > > >
> > > > > > Hi Mani,
> > > > > >
> > > > > > Forgive me as I'm not yet super familiar with the thermal subsystem.
> > > > > >
> > > > > > As I understand it, the DT layout here enables each control to be referenced
> > > > > > under the thermal zones, at least this is the approach taken in CAF 4.9.
> > > > > >
> > > > > > Maybe I don't quite understand what you mean, are you saying that using
> > > > > > thermal zones is the wrong approach?
> > > > >
> > > > > Thermal framework expects each thermal zone represented in DT to have atleast
> > > > > one corresponding thermal sensor defined using "thermal-sensors" property. But
> > > > > with TMD, there is no thermal sensor AFAIK.
> > > >
> > > > As far as I understand, no. It is perfectly fine to have 'cooling'
> > > > devices, which react to external thermal monitoring events. I might be
> > > > mistaken, but I think that is the case here, isn't it?
> > > >
> > >
> > > Yes it is represented as cooling device(s). But I do not see any cognizant way
> > > to plug it with thermal zones i.e., unless TMD itself reports temperature of the
> > > modem, using it as a cooling device for external temperature events doesn't
> > > sound good to me.
> > 
> > Why? We have compute, q6, wlan tsens sensors. So it seems natural to
> > tell CDSP to slow down if compute sensor reports overheating.
> > 
> 
> TMD is for external devices such as PCIe modems as well. Is there a temperature
> sensor for that?
> 

According to the schematics for the SC8280XP CRD sys_therm5 would be the
sensor you're looking for.

Regards,
Bjorn
