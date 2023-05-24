Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1492710195
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 01:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEXXQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 May 2023 19:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXXQ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 19:16:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954099
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684970186; x=1716506186;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=A2FqvhLyssRN2VUlpnlAyU18AJA7kp1q2GkgQNo7Kp4=;
  b=O5izqKYCyInm9FQlbwbrHnnARvyLSbP580im1FsFxqjJCwoQNOr5JbuG
   d+uVQqF44JeCZsq+3WXpbEEFI8w1l+ETEte0jWI9d+dzmNlTQwQbSNilS
   I8xGkkyFfDOZoJ0PuzJC0LECDRNyCFhcCSZ2HNQdwoT+EQCVm7zul4xn3
   Muxx0NmVWLmA53RuPmi2V1DOeg8p0oR9J1R04ISudAJxEiEZghkM9A0us
   9kQhbJAaMRG1A8OTUJLbR+ERyM6XR+TTDIrdua6lxe7tXwcE4UO4BgLyx
   rFyAGnbPSR6y0erzzfWux7I8HU5P2bdWWdCjpZDkLG2O9IPOSC7TGwS5T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="343182646"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="343182646"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 16:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951221614"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="951221614"
Received: from khourymi-mobl.amr.corp.intel.com ([10.213.181.140])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 16:16:25 -0700
Message-ID: <6a712fb99c97d24bffb602cc99dcd69e6fe41d74.camel@linux.intel.com>
Subject: Re: [v2] powercap: intel_rapl: Optimize rp->domains memory
 allocation
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        xiongxin <xiongxin@kylinos.cn>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org
Date:   Wed, 24 May 2023 16:16:22 -0700
In-Reply-To: <CAJZ5v0juDz6=P23NJ11mNCVBCjp_p3qNRFo0i8YqFBPUW9tkQQ@mail.gmail.com>
References: <20230407024759.2320858-1-xiongxin@kylinos.cn>
         <CAJZ5v0juDz6=P23NJ11mNCVBCjp_p3qNRFo0i8YqFBPUW9tkQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2023-05-24 at 18:40 +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 7, 2023 at 4:48=E2=80=AFAM xiongxin <xiongxin@kylinos.cn> wro=
te:
> >=20
> > In the memory allocation of rp->domains in rapl_detect_domains(),
> > there
> > is an additional memory of struct rapl_domain allocated, optimize
> > the
> > code here to save sizeof(struct rapl_domain) bytes of memory.
> >=20
> > Test in Intel NUC (i5-1135G7).
> >=20
> > Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> > Tested-by: xiongxin <xiongxin@kylinos.cn>
> > ---
> >=20
> > v2: The extra memory will never be used, so can directly remove
> > '+1'.
> >=20
> > =C2=A0drivers/powercap/intel_rapl_common.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 8970c7b80884..a766d6e43c34 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1319,7 +1319,7 @@ static int rapl_detect_domains(struct
> > rapl_package *rp, int cpu)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("found %d domains o=
n %s\n", rp->nr_domains, rp-
> > >name);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rp->domains =3D kcalloc(rp->nr_do=
mains + 1, sizeof(struct
> > rapl_domain),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rp->domains =3D kcalloc(rp->nr_do=
mains, sizeof(struct
> > rapl_domain),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rp->domains)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > --
>=20
> Srinivas, is this OK, or does it miss anything?
Looks good.

Reviewed-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>
>=20
> >=20

