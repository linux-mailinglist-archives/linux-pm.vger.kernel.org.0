Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4341FFD5C6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 07:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKOGHN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 01:07:13 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:49926 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbfKOGHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 01:07:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08837032|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0377916-0.00102263-0.961186;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.G-yTRwf_1573798030;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.G-yTRwf_1573798030)
          by smtp.aliyun-inc.com(10.194.99.21);
          Fri, 15 Nov 2019 14:07:10 +0800
Date:   Fri, 15 Nov 2019 14:06:04 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     =?utf-8?B?6bqm6ZSu5qif?= <maijianzhang@allwinnertech.com>,
        =?utf-8?B?5p2O6Z2ZcHN3?= <lijingpsw@allwinnertech.com>
Subject: [power supply]:missing definition without config
Message-ID: <20191115060604.GE17312@AExdroid03>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?utf-8?B?6bqm6ZSu5qif?= <maijianzhang@allwinnertech.com>,
        =?utf-8?B?5p2O6Z2ZcHN3?= <lijingpsw@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: fuyao_love_xxt.Allwinnertech.Technology
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

linux-pm:
hi, walk around the power_supply.h file. 
call power_supply_get_by_name without the CONFIG_POWER_SUPPLY, cause
error.
if we should use:

#ifdef CONFIG_POWER_SUPPLY
extern extern struct power_supply *power_supply_get_by_name(const char *name);
#else
static inline struct power_supply *
power_supply_get_by_name(const char *name)
{return NULL;}
#endif

