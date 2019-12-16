Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9689E11FF62
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 09:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLPIHq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 16 Dec 2019 03:07:46 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57951 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfLPIHp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 03:07:45 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BD3DAE0013;
        Mon, 16 Dec 2019 08:07:42 +0000 (UTC)
Date:   Mon, 16 Dec 2019 09:07:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zak Hays <zak.hays@lexmark.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] thermal: armada: fix register offsets for AXP
Message-ID: <20191216090741.04ade41d@xps13>
In-Reply-To: <BN8PR10MB337990B7688320D736760BB68C580@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1575917171-11085-1-git-send-email-zhays@lexmark.com>
        <BN8PR10MB337990B7688320D736760BB68C580@BN8PR10MB3379.namprd10.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Zak,

Zak Hays <zak.hays@lexmark.com> wrote on Mon, 9 Dec 2019 18:55:51 +0000:

> As shown in its device tree, Armada XP has the control1 register at
> 0x184d0, not 0x182d0.
> 
> Signed-off-by: Zachary Hays <zhays@lexmark.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
