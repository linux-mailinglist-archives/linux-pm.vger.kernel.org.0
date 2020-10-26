Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18521298A44
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 11:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768434AbgJZKUn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 06:20:43 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:65460 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1768190AbgJZKUn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 06:20:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09QAGZU2007483;
        Mon, 26 Oct 2020 05:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=lkYlli3OMljai2JtkMwxmqFfOi6BNmDtsvof4JQOCZA=;
 b=khzBKqeg/FqD/A73fGDr+fubPuyfLzptTVNl3i4wbpObRQO7CHk2n2dwmuztoK4PmLE9
 1QKAeohO4TxgNX04hz+8EgZKzqF1ZrZlX2ogCpCuS61f/vpHFoZwrHUk9IOklabkuVvy
 ExY55d0nO8AZrCjwxlpHQeGVS/13vUO4GkKlZbT3Kh6C90kD5271Y5e+B1CYFU72rOkB
 D6SrS6m6w+kui8uDug5siTVTz7P31Q1cajhUFQYLIjKcM8wkeaufFmp1nJ22OpasX3u8
 KwjuQ/NI3MglYw67omnnto9FouD5YYiNnYq5l3gZRh46Ygz8ifK54H5HLFno5KUNME6n uQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 34chp1jnw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 05:20:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 26 Oct
 2020 10:20:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 26 Oct 2020 10:20:37 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 675762C1;
        Mon, 26 Oct 2020 10:20:37 +0000 (UTC)
Date:   Mon, 26 Oct 2020 10:20:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <trix@redhat.com>
CC:     <sre@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: remove unneeded break
Message-ID: <20201026102037.GC10899@ediswmail.ad.cirrus.com>
References: <20201019185937.7012-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201019185937.7012-1-trix@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=1 priorityscore=1501 mlxlogscore=705
 mlxscore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260073
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 19, 2020 at 11:59:37AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a goto
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
