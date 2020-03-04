Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1931796DA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 18:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCDRhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 12:37:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:31243 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgCDRhe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 12:37:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 09:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="229399961"
Received: from ayeshakh-mobl.amr.corp.intel.com ([10.252.205.163])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2020 09:37:32 -0800
Message-ID: <b524cb9c2c61bf90087ad7174a84b754143d376a.camel@linux.intel.com>
Subject: Re: [RFC PATCH v2 0/2] Introduce multi PM domains helpers
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, rjw@rjwysocki.net,
        len.brown@intel.com
Cc:     aisheng.dong@nxp.com, pierre-louis.bossart@linux.intel.com,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
        alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        khilman@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        shawnguo@kernel.org, festevam@gmail.com, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 04 Mar 2020 09:37:32 -0800
In-Reply-To: <20200304121943.28989-1-daniel.baluta@oss.nxp.com>
References: <20200304121943.28989-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-03-04 at 14:19 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> i.MX8QXP/i.MX8QM has IPs that need multiple power domains to be up
> in order to work. In order to help drivers, we introduce multi PM
> domains helpers that are able to activate/deactivate multi PM
> domains.
> 
> First patch introduces the helpers and second patch demonstrates how
> a driver can use them instead of hardcoding the PM domains handling.
> 
> Changes since v1: (addressed Ranjani's comments)
> 	- enhanced description for dev_multi_pm_attach return value
> 	- renamed exit_unroll_pm label to exit_detach_pm
> 
> Daniel Baluta (2):
>   PM / domains: Introduce multi PM domains helpers
>   ASoC: SOF: Use multi PM domains helpers
Both patches LGTM. Thanks Daniel.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

