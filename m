Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17E041EE86
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhJAN3M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 09:29:12 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:6536 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231700AbhJAN1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 09:27:23 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191CQQAR025627;
        Fri, 1 Oct 2021 08:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=BlIHIqtr1k2ONbmVBbvNuwbDQJ1cE8q8zaHeDBEFRFo=;
 b=FHDDKo3FUPyj7uA1rJz5c30+pi3G80Jn8fVbeNu92AHTMLmE8epU9GQcWAU37SqJM+ZZ
 u9bVy8NQeXag71tpA0t+2YuYqLdEak/jR2y56FSLwQGWIku7iHbqlqhDvTDFK8f3TXny
 f2ubYP8U7stOn1njsBnhgjfpHoGcOyyf99TOKxC7iZe2M0KI/s3iZyyKI/y7dLtiD2xP
 1DYcxGdtxkB7r5XA/5DXby0ENE5rGPkStecYWH6Jpl05d2z9w8mkeGnSNCgpiefoWAUd
 MW9CIxmRW1Kj05HEUNYu8eaVQbBUjsoWVzP/IITRq5cr2kTS8cujQjx3Jk+elrD7/MEs Qg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bdmfw0xgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 01 Oct 2021 08:25:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 1 Oct
 2021 14:25:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 1 Oct 2021 14:25:34 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A84411AF;
        Fri,  1 Oct 2021 13:25:34 +0000 (UTC)
Date:   Fri, 1 Oct 2021 13:25:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Colin King <colin.king@canonical.com>
CC:     Sebastian Reichel <sre@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-pm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: wm831x_power: fix spelling mistake on
 function name
Message-ID: <20211001132534.GJ9223@ediswmail.ad.cirrus.com>
References: <20211001120449.17914-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211001120449.17914-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: SrR3VPjBzT9Twp7qjYXrEV6izYoaaOCR
X-Proofpoint-ORIG-GUID: SrR3VPjBzT9Twp7qjYXrEV6izYoaaOCR
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 01, 2021 at 01:04:49PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the name wm831x_battey_apply_config,
> fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
