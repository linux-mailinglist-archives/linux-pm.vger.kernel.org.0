Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA87BA167
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbjJEOnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Oct 2023 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbjJEOi2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2023 10:38:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883834F077;
        Thu,  5 Oct 2023 07:02:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3952obcM020199;
        Thu, 5 Oct 2023 02:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=dFUWap6jlVEo0/FWKF6ZbuQBL/+MeVOOJ+8zsML8Umo=;
 b=edDpNhoHl+kWZPg5qVWs2Gzi7Y81akUnBumc1EpagtG3tiiGNE/zIMkzrpwP8D3wtJOJ
 q7LEHVmd6ww7Q6IjqC3NoaGxWO0fp7Xmfcyw5cMFrukL2REFE6UP1jED3rgj0Re84fdW
 FfHaiRIcSCEQ3m0tlDQ6WBoVNTIjEm5kZp0pc+Oh61L3SAQEN/WlG1ikGJEaYEwNTp5E
 BTKXlK330LmGV6+LQYcelciZH+Pv6YQzvSal9US7e/UBPtWuIieteax0GbZVQzx4qFDK
 0dm0wRa0dkZde2v8rKkeiq2a5S1i02Ynl7TXW4n68w4AdxIpq47RFApBxmXOcqH2H7TX LQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thj6gg9hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 02:52:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3952q7YM016314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 02:52:07 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 4 Oct 2023 19:52:07 -0700
Date:   Wed, 4 Oct 2023 19:52:06 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation
 Device support
Message-ID: <20231005025206.GF3553829@hu-bjorande-lv.qualcomm.com>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20231001155701.GA53767@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001155701.GA53767@thinkpad>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FrSBzj2ulkS9SaY4CyHpLk6gx13PtlDB
X-Proofpoint-ORIG-GUID: FrSBzj2ulkS9SaY4CyHpLk6gx13PtlDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 01, 2023 at 09:27:01PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
> > The Thermal Mitigation Device (TMD) Service is a QMI service that runs
> > on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
> > It exposes various mitigations including passive thermal controls and
> > rail voltage restrictions.
> > 
> > This series introduces support for exposing TMDs as cooling devices
> > in the kernel through the thermal framework, using the QMI interface.
> > 
> > Each TMD client is described as a child of the remoteproc node in
> > devicetree. With subnodes for each control.
> > 
> 
> Daniel expressed concerns in the past aganist representing TMD driver as a
> cooling device since it is not tied to thermal zones and the governors cannot
> use it. Instead he suggested to represent it as a powercap device with thermal
> constraints.
> 
> So please look into that approach.
> 

The powercap framework revolves around the idea that we have some amount
of power (micro-watt) being available to the system, which can be split
across a range of devices.

Say that we implement this as a powercap thing, what current consumption
would you attribute these entires? How would you map a given uW value to
the mitigation levels provided by the qmi-cooling instances?


Beyond that, I'm still not sure how we would plug this in. We don't have
a picture of the power consumption/flow through the system at any point
in time - as the control of the power grid is distributed across the
various subsystems.

Regards,
Bjorn
