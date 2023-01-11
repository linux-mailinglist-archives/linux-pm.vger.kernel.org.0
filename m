Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E966608D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjAKQdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Jan 2023 11:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjAKQco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2023 11:32:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4A3725D
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 08:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454723; x=1704990723;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=Q0UH5hjEPF8drl7W+YlGzmE70Ou8P01EfZZslZsAJw8=;
  b=fcpiyRBTcsigN9ctsvYBXQii3A+/7Cjq5cmtYkl/U3jxIhDgWt9Ze8Mi
   BiesGZr80xmCw0y6j7Vz1saKCQV82OZDqNIAYWYHM1Qhr+7aSzsQiw51Z
   rbpJoWkGLxc40My4kIbPnZsvTlqM4QUFcgpmHC4ZEEf3b8diL+jDhZG+G
   PJa1r+i+wEHFipQQYCcaykpwsJAQZen3F+mvYR/1Iag8oc/XSlM9GTp2k
   XQwuPLlf0kQlEvoU+EOC+ckVZwOuUu9rM9cDOj7aGIWJTx/Yikml2pN4T
   KdSUlU9FkSPxulDZRONs7fmDqgSSNqijB6X/2JhFwVJOx4znFrRO/4Zsf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306982333"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="306982333"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781453496"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="781453496"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 08:29:22 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 8DD61580AD7;
        Wed, 11 Jan 2023 08:29:21 -0800 (PST)
Message-ID: <0b1d39d1ad323ef815f5db133753a990375eb45d.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power turbostat: Introduce support for EMR
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, len.brown@intel.com
Date:   Wed, 11 Jan 2023 18:29:20 +0200
In-Reply-To: <20230104142353.22871-1-rui.zhang@intel.com>
References: <20230104142353.22871-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

On Wed, 2023-01-04 at 22:23 +0800, Zhang Rui wrote:
> Introduce support for EMR.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> =C2=A0tools/power/x86/turbostat/turbostat.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/tools/power/x86/turbostat/turbostat.c
> b/tools/power/x86/turbostat/turbostat.c
> index aba460410dbd..5073e5cdfec5 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -5463,6 +5463,9 @@ unsigned int intel_model_duplicates(unsigned int mo=
del)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case INTEL_FAM6_ICELAKE_D=
:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return INTEL_FAM6_ICELAKE_X;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case INTEL_FAM6_EMERALDRAPIDS_=
X:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return INTEL_FAM6_SAPPHIRERAPIDS_X;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return model;
> =C2=A0}

