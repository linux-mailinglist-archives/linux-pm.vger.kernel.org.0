Return-Path: <linux-pm+bounces-29564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C367DAE99F5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35516A28C6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7C2264C3;
	Thu, 26 Jun 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFmIi7VV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0D18035;
	Thu, 26 Jun 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930210; cv=none; b=fQGxvnohAyMnDqmTW3b68ZmQdThP5ejpMp8mQlv9okxTBP9r7YbBiqfghlzbxAUNe0TEdN/bph+bLKEP7oyX5NoWo9lN3QB++VCFfHTHie9bAApT7aZFEGOBQWmwU7bJVlvlprpXhB/Ul0cpBhb1NIMYgTHMrZjXHvBIqfAoEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930210; c=relaxed/simple;
	bh=a2K8GLkF5znAupHCEiUMEzBdjik2VJ4kd+zz431U6X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDNhJCNL7wS+UvRbWAR43Qv4hZC4e4e/kzTGFcraUp31caDwFCkPM0zkle4Nm3GvUg+Zw2BL0ymS5Ed1eFDWZAVteeoLCiyHAedu0RFnDwUc479scdU8c4gC3l21+g0dx2UiHUAFY1JM2nvv/QWMJfn1RHCQNp66kuoZqVkmcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFmIi7VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50718C4CEEE;
	Thu, 26 Jun 2025 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750930210;
	bh=a2K8GLkF5znAupHCEiUMEzBdjik2VJ4kd+zz431U6X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFmIi7VV9i1zrdEoQFYHByOFpmohqPzrmwySV5XYYmhUpT/V9/spDeDkqYzphWn2A
	 ix+/fjHHcNmFd0hRs5sQVslD8Kd0jNvbJOWDntuSJa2afCNuPzz1UPI1niAzgAz3G9
	 5zJ5fX9QDDrxvED49FjQ52ZH1mMkt5T7VVUclF6ybBFbqx6R/toKUcE2qDiAgna8pf
	 Dkdf02IP7Qbskos6DoAyHW0kZObE7w0DcNiseDWPRYcI25AaDxZm6hzaVdCWBm2usj
	 hrlT4Hmz7rUKUyp8FzNeBUH5SwLJeb1B5Yk3ZOlposzSME9B4nsnKixfx5wCwGantD
	 0EhajUZ8gy7nQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUivp-00000000786-14NF;
	Thu, 26 Jun 2025 11:30:09 +0200
Date: Thu, 26 Jun 2025 11:30:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Message-ID: <aF0TIWfDI4M1azzc@hovoldconsulting.com>
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
 <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
 <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>

On Wed, Jun 25, 2025 at 05:35:07PM +0200, Gabor Juhos wrote:
> 2025. 06. 25. 16:02 keltezéssel, Johan Hovold írta:
> > On Wed, Jun 25, 2025 at 03:15:53PM +0200, Gabor Juhos wrote:
> >> 2025. 06. 25. 14:41 keltezéssel, Johan Hovold írta:
> >>> On Wed, Jun 25, 2025 at 02:30:15PM +0200, Johan Hovold wrote:
> >>>> On Wed, Jun 25, 2025 at 01:25:04PM +0200, Gabor Juhos wrote:
> >>>
> >>>>> @@ -276,13 +276,17 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
> >>>>>  		qcom_icc_bcm_init(qp->bcms[i], dev);
> >>>>>  
> >>>>>  	for (i = 0; i < num_nodes; i++) {
> >>>>> +		bool is_dyn_node = false;
> >>>>> +
> >>>>>  		qn = qnodes[i];
> >>>>>  		if (!qn)
> >>>>>  			continue;
> >>>>>  
> >>>>>  		if (desc->alloc_dyn_id) {
> >>>>> -			if (!qn->node)
> >>>>> +			if (!qn->node) {
> >>>>
> >>>> AFAICS, qn->node will currently never be set here and I'm not sure why
> >>>> commit 7f9560a3bebe ("interconnect: qcom: icc-rpmh: Add dynamic icc node
> >>>> id support") added this check, or even the node field to struct
> >>>> qcom_icc_desc for that matter.
> >>>>
> >>>> But if there's some future use case for this, then you may or may not
> >>>> need to make sure that a name is allocated also in that case.
> >>>
> >>> Ok, I see what's going on. The qn->node may have been (pre-) allocated
> >>> in icc_link_nodes() dynamically, which means you need to make sure to
> >>> generate a name also in that case.
> >>>
> >>>> And that could be done by simply checking if node->id >=
> >>>> ICC_DYN_ID_START instead of using a boolean flag below. That may be
> >>>> preferred either way.
> >>>
> >>> So you should probably use node->id to determine this.
> >>
> >> You are right. The problem is that ICC_DYN_ID_START is only visible from the
> >> core code. Either we have to move that into the 'interconnect-provider.h' header
> >> or we have to add an icc_node_is_dynamic() helper or something similar.
> >>
> >> Which is the preferred solution?
> > 
> > I think adding a helper like icc_node_is_dynamic() in a separate
> > preparatory patch is best here.
> 
> Ok, although i don't see why it should be done in a separate patch.

Since this is a 6.16-rc1 regression (which does not need to be
backported) it should be fine to add the helper in the same patch.

> > If it wasn't for nodes now being created also in icc_link_nodes() we
> > could otherwise perhaps just as well have moved the name generation into
> > icc_node_create_dyn().
> 
> I already have tried to add the name allocation to the icc_node_create_dyn()
> function, but I was not satisfied with the result. B

Yeah, the preallocation complicates this too.

> > Now it seems we'd need a new helper to set the
> > name (or add error handling for every icc_node_add()), but we've already
> > spent way too much time trying to clean up this mess...
> 
> True, and the patch is getting more and more complicated with each iteration. :)
> 
> Nevertheless, I think that we can have a simpler solution. We can create a
> wrapper around icc_node_add(), and allocate the name from there. I mean
> something like this:
> 
> int icc_node_add_dyn(struct icc_node *node, struct icc_provider *provider)
> {
> 	if (node->id >= ICC_DYN_ID_START) {
> 		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
> 					    node->name, dev_name(provider->dev));
> 		if (!node->name)
> 			return -ENOMEM;
> 	}
> 
> 	icc_node_add(node, provider);
> 	return 0;
> }
> 
> Then we can change the qcom_icc_rpmh_probe() and qcom_osm_l3_probe() to use the
> wrapper instead of the plain version. Since the wrapper can return an error
> code, it can be handled in the callers. And as a bonus, we don't have to touch
> other users of icc_node_add() at all.

That would be a smaller change indeed, but I don't think we should
change the current model of:

	node = icc_node_create()
	<manual initialisation of the node>
	icc_node_add(node)

So given that we need to add some new helper (or export the internal ID
define), I think we might as well add that icc_node_set_name() helper I
suggested might be the long term solution here directly.

I also don't like hiding device managed allocations (those should be done
explicitly with devm_ prefix helpers so that the callers can reason
about ordering) so I dropped that as well.

So something like the below. Note that this could be extended with a
name-allocated flag and an appropriate warning somewhere later if anyone
is worried about drivers failing to use the helper.

Note that we can't use kfree_const() unconditionally as I initially
intended as apparently some interconnect providers already allocate
names for non-dynamic nodes.

Johan


From 8f4f936ebd87f9ceb0a799f89f322a25c6fcd05b Mon Sep 17 00:00:00 2001
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 25 Jun 2025 13:25:04 +0200
Subject: [PATCH] interconnect: avoid memory allocation when 'icc_bw_lock' is
 held

The 'icc_bw_lock' mutex is introduced in commit af42269c3523
("interconnect: Fix locking for runpm vs reclaim") in order to decouple
serialization of bw aggregation from codepaths that require memory
allocation.

However commit d30f83d278a9 ("interconnect: core: Add dynamic id
allocation support") added a devm_kasprintf() call into a path protected
by the 'icc_bw_lock' which causes this lockdep warning (at least on the
IPQ9574 platform):

    ======================================================
    WARNING: possible circular locking dependency detected
    6.15.0-next-20250529 #0 Not tainted
    ------------------------------------------------------
    swapper/0/1 is trying to acquire lock:
    ffffffc081df57d8 (icc_bw_lock){+.+.}-{4:4}, at: icc_init+0x8/0x108

    but task is already holding lock:
    ffffffc081d7db10 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x28/0x108

    which lock already depends on the new lock.

    the existing dependency chain (in reverse order) is:

    -> #1 (fs_reclaim){+.+.}-{0:0}:
           fs_reclaim_acquire+0x7c/0xb8
           slab_alloc_node.isra.0+0x48/0x188
           __kmalloc_node_track_caller_noprof+0xa4/0x2b8
           devm_kmalloc+0x5c/0x138
           devm_kvasprintf+0x6c/0xb8
           devm_kasprintf+0x50/0x68
           icc_node_add+0xbc/0x160
           icc_clk_register+0x15c/0x230
           devm_icc_clk_register+0x20/0x90
           qcom_cc_really_probe+0x320/0x338
           nss_cc_ipq9574_probe+0xac/0x1e8
           platform_probe+0x70/0xd0
           really_probe+0xdc/0x3b8
           __driver_probe_device+0x94/0x178
           driver_probe_device+0x48/0xf0
           __driver_attach+0x13c/0x208
           bus_for_each_dev+0x6c/0xb8
           driver_attach+0x2c/0x40
           bus_add_driver+0x100/0x250
           driver_register+0x68/0x138
           __platform_driver_register+0x2c/0x40
           nss_cc_ipq9574_driver_init+0x24/0x38
           do_one_initcall+0x88/0x340
           kernel_init_freeable+0x2ac/0x4f8
           kernel_init+0x28/0x1e8
           ret_from_fork+0x10/0x20

    -> #0 (icc_bw_lock){+.+.}-{4:4}:
           __lock_acquire+0x1348/0x2090
           lock_acquire+0x108/0x2d8
           icc_init+0x50/0x108
           do_one_initcall+0x88/0x340
           kernel_init_freeable+0x2ac/0x4f8
           kernel_init+0x28/0x1e8
           ret_from_fork+0x10/0x20

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(fs_reclaim);
                                   lock(icc_bw_lock);
                                   lock(fs_reclaim);
      lock(icc_bw_lock);

     *** DEADLOCK ***

    1 lock held by swapper/0/1:
     #0: ffffffc081d7db10 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x28/0x108

    stack backtrace:
    CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-next-20250529 #0 NONE
    Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
    Call trace:
     show_stack+0x20/0x38 (C)
     dump_stack_lvl+0x90/0xd0
     dump_stack+0x18/0x28
     print_circular_bug+0x334/0x448
     check_noncircular+0x12c/0x140
     __lock_acquire+0x1348/0x2090
     lock_acquire+0x108/0x2d8
     icc_init+0x50/0x108
     do_one_initcall+0x88/0x340
     kernel_init_freeable+0x2ac/0x4f8
     kernel_init+0x28/0x1e8
     ret_from_fork+0x10/0x20

The icc_node_add() functions is not designed to fail, and as such it
should not do any memory allocation. In order to avoid this, add a new
helper function for the name generation to be called by the functions
which are using the dynamic id feature.

Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Link: https://lore.kernel.org/r/20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com
Co-developed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/core.c           | 29 +++++++++++++++++++++++----
 drivers/interconnect/qcom/icc-rpmh.c  |  7 ++++++-
 drivers/interconnect/qcom/osm-l3.c    |  7 ++++++-
 include/linux/interconnect-provider.h |  6 ++++++
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f8..fdfc755bbd43 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -906,10 +906,35 @@ void icc_node_destroy(int id)
 		return;
 
 	kfree(node->links);
+	if (node->id >= ICC_DYN_ID_START)
+		kfree(node->name);
 	kfree(node);
 }
 EXPORT_SYMBOL_GPL(icc_node_destroy);
 
+/**
+ * icc_node_set_name() - set node name
+ * @node: node
+ * @provider: node provider
+ * @name: node name
+ *
+ * Return: 0 on success, or -ENOMEM on allocation failure
+ */
+int icc_node_set_name(struct icc_node *node, const struct icc_provider *provider, const char *name)
+{
+	if (node->id >= ICC_DYN_ID_START) {
+		node->name = kasprintf(GFP_KERNEL, "%s@%s", name,
+				       dev_name(provider->dev));
+		if (!node->name)
+			return -ENOMEM;
+	} else {
+		node->name = name;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_node_set_name);
+
 /**
  * icc_link_nodes() - create link between two nodes
  * @src_node: source node
@@ -1038,10 +1063,6 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
 
-	if (node->id >= ICC_DYN_ID_START)
-		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
-					    node->name, dev_name(provider->dev));
-
 	if (node->avg_bw || node->peak_bw) {
 		if (provider->pre_aggregate)
 			provider->pre_aggregate(node);
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 41bfc6e7ee1d..001404e91041 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -293,7 +293,12 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 			goto err_remove_nodes;
 		}
 
-		node->name = qn->name;
+		ret = icc_node_set_name(node, provider, qn->name);
+		if (ret) {
+			icc_node_destroy(node->id);
+			goto err_remove_nodes;
+		}
+
 		node->data = qn;
 		icc_node_add(node, provider);
 
diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index baecbf2533f7..b33f00da1880 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -236,7 +236,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 			goto err;
 		}
 
-		node->name = qnodes[i]->name;
+		ret = icc_node_set_name(node, provider, qnodes[i]->name);
+		if (ret) {
+			icc_node_destroy(node->id);
+			goto err;
+		}
+
 		/* Cast away const and add it back in qcom_osm_l3_set() */
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 55cfebc658e6..37093b6e1af9 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -119,6 +119,7 @@ int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 struct icc_node *icc_node_create_dyn(void);
 struct icc_node *icc_node_create(int id);
 void icc_node_destroy(int id);
+int icc_node_set_name(struct icc_node *node, const struct icc_provider *provider, const char *name);
 int icc_link_nodes(struct icc_node *src_node, struct icc_node **dst_node);
 int icc_link_create(struct icc_node *node, const int dst_id);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider);
@@ -152,6 +153,11 @@ static inline void icc_node_destroy(int id)
 {
 }
 
+static int icc_node_set_name(struct icc_node *node, const struct icc_provider *provider, const char *name)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int icc_link_nodes(struct icc_node *src_node, struct icc_node **dst_node)
 {
 	return -EOPNOTSUPP;
-- 
2.49.0


