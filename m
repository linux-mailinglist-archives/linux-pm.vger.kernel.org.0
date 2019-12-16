Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9E11FF96
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 09:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLPIUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 03:20:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38770 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLPIUi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 03:20:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so3259462edr.5
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 00:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B42kf8tcfOTM0hEAUoK/Z+JIyTieV2qindWOz+4c/qU=;
        b=TCtroBNy/TJhIfc+CbYSxQwFvZ4+pRl7WBHNZgOAbOpYCpoIU5Hy4NuYVgYAU51Ynv
         yEEBAUaj2xGRilx+BcY93DykOcJD3ahYSQNoa4SvQaN2M/O/gOlCcDC6KSnpqWHpzh29
         Q2sdZfhXtlc+bFgc08PGxrU8hxwQsg+W2ozvXXpE+VaRBzIBUPqEmQemLGVUr7hXQR8I
         yIeoOQLUfEyc5+1AmyzT3Sd1c6rDfHLNr2gjwOT85J1u5ikS9sluGvYyuSwTq7xWnwk9
         0UskzF/pJjczFfj6moHNycMjbgkRnaes5/t+YVPtRA1Bk3iF0jwzLtBHYQ5tsRShJNaI
         H9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B42kf8tcfOTM0hEAUoK/Z+JIyTieV2qindWOz+4c/qU=;
        b=LisMzgg8QYbtMH313xMx4hNuSNHUjXRLT/IKg1c2Qt0Y5kdMx6cyTFH8S4PALlY/NS
         4d4bdKJ5YEWAZjBnOEb5RDfCwMx8BXSLjQqLKtgQPI00FTyNfTvMeGXe466xg6ebbniZ
         oSbo6s5LGXuK+znUqFwHGNRxSFwHDmlkKcqKllrFU+MVqXEDQaimm9OaPEa0fwPxgBIr
         gaQMUAT37dVY+fxsmvpajIG7a0dvbkViR2VnfVfFS5ACPU1rtAUyVqp+chaggnxM+fOW
         PyyqRkbijJ5o2vScKBzq7LgUasO2frCWIWyTmZI9cAPPYFzaX+qdva1/XIwxjSFw06Am
         sNpA==
X-Gm-Message-State: APjAAAUjgO5iX+U93sCmy25g94wKwKJ3WGvx2TRXCXR//IljMRPsxm5+
        Jgm1o3BQXjNqblrdc6gklXsniw==
X-Google-Smtp-Source: APXvYqzgdrFCVcNyHD61BwhFd/MwWmE9Uem6R2GyqU5L1b6Zmtu7fUSeaHro/1BAt8jmU2G0yjqNeQ==
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr627839ejb.8.1576484435622;
        Mon, 16 Dec 2019 00:20:35 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id hk19sm1054338ejb.41.2019.12.16.00.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 00:20:34 -0800 (PST)
Subject: Re: [PATCH v2] interconnect: Add interconnect_graph file to debugfs
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <6798d1469dd31609e76d13f5ac6249f7af48456a.1574116163.git.leonard.crestez@nxp.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <ba2bea60-5a19-ba10-6653-4200ac046782@linaro.org>
Date:   Mon, 16 Dec 2019 10:20:32 +0200
MIME-Version: 1.0
In-Reply-To: <6798d1469dd31609e76d13f5ac6249f7af48456a.1574116163.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 19.11.19 г. 0:34 ч., Leonard Crestez wrote:
> The interconnect graphs can be difficult to understand and the current
> "interconnect_summary" file doesn't even display links in any way.
> 
> Add a new "interconnect_graph" file to debugfs in the graphviz "dot"
> format which describes interconnect providers, nodes and links.
> 
> The file is human-readable and can be visualized by piping through
> graphviz. Example:
> 
> ssh $TARGET cat /sys/kernel/debug/interconnect/interconnect_graph \
> 	| dot -Tsvg > interconnect_graph.svg
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   Documentation/driver-api/interconnect.rst | 23 ++++++++
>   drivers/interconnect/core.c               | 66 +++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
> 
> Example output as a github gist:
> https://gist.github.com/cdleonard/2f74a7efe74587e3d4b57cf7983b46a8
> 
> The qcs404 driver was hacked to probe on imx, the links to "0" seem to
> from incorrect trailing 0s on DEFINE_QNODE. Possibly fallout from
> switching to ARRAY_SIZE(__VA_ARGS__)?
> 
> This makes it easier to understand the interconnect graph than just
> staring at registration code.
> 
> Changes since RFC v1:
> * Document under driver-api/interconnect.rst
> * Collect reviews
> Link to v1: https://patchwork.kernel.org/patch/11242921/
> 
> diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
> index cdeb5825f314..77a85aad8d2f 100644
> --- a/Documentation/driver-api/interconnect.rst
> +++ b/Documentation/driver-api/interconnect.rst
> @@ -89,5 +89,28 @@ Interconnect consumers
>   
>   Interconnect consumers are the clients which use the interconnect APIs to
>   get paths between endpoints and set their bandwidth/latency/QoS requirements
>   for these interconnect paths.  These interfaces are not currently
>   documented.
> +
> +Interconnect debugfs interfaces
> +-------------------------------
> +
> +Like several other subsystems interconnect will create some files for debugging
> +and introspection. Files in debugfs are not considered ABI so application
> +software shouldn't rely on format details
> +change between kernel versions.
> +
> +``/sys/kernel/debug/interconnect/interconnect_summary``:
> +
> +Show all interconnect nodes in the system with their aggregated bandwith

s/bandwith/bandwidth/

> +request. Indented under each node show bandwith requests from each device.

s/bandwith/bandwidth/

> +
> +``/sys/kernel/debug/interconnect/interconnect_graph``:
> +
> +Show the interconnect graph in the graphviz dot format. It shows all
> +interconnect nodes and links in the system and groups together nodes from the
> +same provider as subgraphs. The format is human-readable and can also be piped
> +through dot to generate diagrams in many graphical formats::
> +
> +        $ cat /sys/kernel/debug/interconnect/interconnect_graph | \
> +                dot -Tsvg > interconnect_graph.svg
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index c498796adc07..07e91288c7f4 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -92,10 +92,74 @@ static int icc_summary_show(struct seq_file *s, void *data)
>   
>   	return 0;
>   }
>   DEFINE_SHOW_ATTRIBUTE(icc_summary);
>   
> +static void icc_graph_show_link(struct seq_file *s, int level,
> +				struct icc_node *n, struct icc_node *m)
> +{
> +	seq_printf(s, "%s\"%d:%s\" -> \"%d:%s\"\n",
> +			level == 2 ? "\t\t" : "\t",
> +			n->id, n->name, m->id, m->name);

Nit: Should be aligned to the open parenthesis.

> +}
> +
> +static void icc_graph_show_node(struct seq_file *s, struct icc_node *n)
> +{
> +	seq_printf(s, "\t\t\"%d:%s\" [label=\"%d:%s",
> +		   n->id, n->name, n->id, n->name);
> +	seq_printf(s, "\n\t\t\t|avg_bw=%ukBps", n->avg_bw);
> +	seq_printf(s, "\n\t\t\t|peak_bw=%ukBps", n->peak_bw);
> +	seq_puts(s, "\"]\n");
> +}
> +
> +static int icc_graph_show(struct seq_file *s, void *data)
> +{
> +	struct icc_provider *provider;
> +	struct icc_node *n;
> +	int cluster_index = 0;
> +	int i;
> +
> +	seq_puts(s, "digraph {\n\trankdir = LR\n\tnode [shape = record]\n");
> +	mutex_lock(&icc_lock);
> +
> +	/* draw providers as cluster subgraphs */
> +	cluster_index = 0;
> +	list_for_each_entry(provider, &icc_providers, provider_list) {
> +		seq_printf(s, "\tsubgraph cluster_%d {\n", ++cluster_index);
> +		if (provider->dev)
> +			seq_printf(s, "\t\tlabel = \"%s\"\n",
> +				   dev_name(provider->dev));
> +
> +		/* draw nodes */
> +		list_for_each_entry(n, &provider->nodes, node_list)
> +			icc_graph_show_node(s, n);
> +
> +		/* draw internal links */
> +		list_for_each_entry(n, &provider->nodes, node_list)
> +			for (i = 0; i < n->num_links; ++i)
> +				if (n->provider == n->links[i]->provider)
> +					icc_graph_show_link(s, 2, n,
> +							    n->links[i]);
> +
> +		seq_puts(s, "\t}\n");
> +	}
> +
> +	/* draw external links */
> +	list_for_each_entry(provider, &icc_providers, provider_list)
> +		list_for_each_entry(n, &provider->nodes, node_list)
> +			for (i = 0; i < n->num_links; ++i)
> +				if (n->provider != n->links[i]->provider)
> +					icc_graph_show_link(s, 1, n,
> +							    n->links[i]);
> +
> +	mutex_unlock(&icc_lock);
> +	seq_puts(s, "}");
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(icc_graph);
> +
>   static struct icc_node *node_find(const int id)
>   {
>   	return idr_find(&icc_idr, id);
>   }
>   
> @@ -800,10 +864,12 @@ EXPORT_SYMBOL_GPL(icc_provider_del);
>   static int __init icc_init(void)
>   {
>   	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
>   	debugfs_create_file("interconnect_summary", 0444,
>   			    icc_debugfs_dir, NULL, &icc_summary_fops);
> +	debugfs_create_file("interconnect_graph", 0444,
> +			    icc_debugfs_dir, NULL, &icc_graph_fops);
>   	return 0;
>   }
>   
>   static void __exit icc_exit(void)
>   {

This is good stuff! Thank you! I will fix up the typos while applying,
no need to resend it.

BR,
Georgi

