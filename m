Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271E2339E35
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 14:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCMN1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Mar 2021 08:27:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49906 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMN1b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Mar 2021 08:27:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12DDRNoS076194;
        Sat, 13 Mar 2021 07:27:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615642043;
        bh=KXI/B9JGGFolzxZwaWnIn6eigtC0I6NQJdGne4dCDqo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=L/WTmFCUN4KKtgh3sMCxysnkv8P4MqUDCO7VsqQk15F4TJ0WMBJ2doqQOc/q/bSdJ
         Uet8KdmxeNxJpCDF3MoFqIiUNNWZhdpd1rCgv1X26purd6PL09ijldmZP+wP/gopi2
         6SF8Py/M4q2ZGraHpGteMUQCIu3RJk2GyDA+H5xU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12DDRNk8035527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Mar 2021 07:27:23 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 13
 Mar 2021 07:27:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sat, 13 Mar 2021 07:27:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12DDRMon069381;
        Sat, 13 Mar 2021 07:27:22 -0600
Date:   Sat, 13 Mar 2021 07:27:22 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Wang Qing <wangqing@vivo.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: Replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <20210313132722.tctziyeufkb7crto@sizable>
References: <1615606406-2384-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1615606406-2384-1-git-send-email-wangqing@vivo.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11:33-20210313, Wang Qing wrote:
> Fix the following coccicheck warning:
> 	WARNING:pm_sr_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE.
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
