Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE0B7F6A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 18:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfISQws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 12:52:48 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:61673 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfISQws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 12:52:48 -0400
Received: from hp-x360n (unknown [12.245.190.214])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 46Z2vv034czqwd;
        Thu, 19 Sep 2019 12:52:42 -0400 (EDT)
Date:   Thu, 19 Sep 2019 09:52:41 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me help you debug what seems to be an EC resume issue
In-Reply-To: <alpine.DEB.2.21.1909190930190.2842@hp-x360n>
Message-ID: <alpine.DEB.2.21.1909190951590.2842@hp-x360n>
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com> <alpine.DEB.2.21.1909190444190.2973@hp-x360n> <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
 <alpine.DEB.2.21.1909190909440.2973@hp-x360n> <alpine.DEB.2.21.1909190930190.2842@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


This is after a resume. Maybe this is helpful, too?

----
[  +0.002487] intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)
[  +0.000005] intel_pmc_core INT33A1:00: SLP_S0_DBG: AUDIO_D3                           State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: OTG_D3                             State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: XHCI_D3                            State: Yes
[  +0.000002] intel_pmc_core INT33A1:00: SLP_S0_DBG: LPIO_D3                            State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: SDX_D3                             State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: SATA_D3                            State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: UFS0_D3                            State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: UFS1_D3                            State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: EMMC_D3                            State: Yes
[  +0.000005] intel_pmc_core INT33A1:00: SLP_S0_DBG: SDIO_PLL_OFF                       State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: USB2_PLL_OFF                       State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: AUDIO_PLL_OFF                      State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: OC_PLL_OFF                         State: Yes
[  +0.000002] intel_pmc_core INT33A1:00: SLP_S0_DBG: MAIN_PLL_OFF                       State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: XOSC_OFF                           State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: LPC_CLKS_GATED                     State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: PCIE_CLKREQS_IDLE                  State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: AUDIO_ROSC_OFF                     State: Yes
[  +0.000002] intel_pmc_core INT33A1:00: SLP_S0_DBG: HPET_XOSC_CLK_REQ                  State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: PMC_ROSC_SLOW_CLK                  State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: AON2_ROSC_GATED                    State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: CLKACKS_DEASSERTED                 State: No
[  +0.000004] intel_pmc_core INT33A1:00: SLP_S0_DBG: MPHY_CORE_GATED                    State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: CSME_GATED                         State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: USB2_SUS_GATED                     State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: DYN_FLEX_IO_IDLE                   State: Yes
[  +0.000002] intel_pmc_core INT33A1:00: SLP_S0_DBG: GBE_NO_LINK                        State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: THERM_SEN_DISABLED                 State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: PCIE_LOW_POWER                     State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: ISH_VNNAON_REQ_ACT                 State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: ISH_VNN_REQ_ACT                    State: No
[  +0.000002] intel_pmc_core INT33A1:00: SLP_S0_DBG: CNV_VNNAON_REQ_ACT                 State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: CNV_VNN_REQ_ACT                    State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: NPK_VNNON_REQ_ACT                  State: No
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: PMSYNC_STATE_IDLE                  State: Yes
[  +0.000001] intel_pmc_core INT33A1:00: SLP_S0_DBG: ALST_GT_THRES                      State: Yes
[  +0.000002] intel_pmc_core INT33A1:00: SLP_S0_DBG: PMC_ARC_PG_READY                   State: No
----

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
