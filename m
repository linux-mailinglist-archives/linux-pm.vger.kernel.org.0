Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22A132B96
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 17:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgAGQxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 11:53:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgAGQxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 11:53:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 007GrVCC021331;
        Tue, 7 Jan 2020 10:53:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578416011;
        bh=ijxKYPu7aitvqea0/41zctHTvqZLXaM+vZDKrOkjRsQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ykqA+fap61DZYsXo07WKHpClVOPNL9neXBRncMFLINcuPdiv7MgVq7vts1HNv5bNM
         g36WbCu01UBSCG+v4aTcXVf6P8vOTLR1+kH5oh6LEJuMFd8qCmpIkonEWA0k+W3VTv
         n7bi/kHuYnhqrUMz5Brode7Jw+/h7EtW+FMcvV4I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 007GrVur112005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 10:53:31 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 10:53:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 10:53:30 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 007GrUni017504;
        Tue, 7 Jan 2020 10:53:30 -0600
Subject: Re: [PATCH v2 1/3] power_supply: Add additional health properties to
 the header
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191029200201.24483-1-dmurphy@ti.com>
 <20191219171910.wbx4ry6hgip6g4fm@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <852a3e66-3773-0bfe-33b9-87cc514a4a11@ti.com>
Date:   Tue, 7 Jan 2020 10:50:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219171910.wbx4ry6hgip6g4fm@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 12/19/19 11:19 AM, Sebastian Reichel wrote:
> Hi Dan,
>
> On Tue, Oct 29, 2019 at 03:01:59PM -0500, Dan Murphy wrote:
>> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
> This needs to update /sys/class/power_supply/<supply_name>/health
> entry in Documentation/ABI/testing/sysfs-class-power. Also it needs

I noticed "Over Current" was missing from the ABI doc.  Do you want that 
addition in a separate patch or can I add it in my update?

Dan

<snip>

