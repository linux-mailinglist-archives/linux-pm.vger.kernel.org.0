Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB64FBE72
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 04:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNDuD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 22:50:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34786 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNDuD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 22:50:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so2809778pgb.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 19:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=umYuaqH/vbuPE2RKme3P+diNf3XB7pJeeiLOBWpjlxQ=;
        b=gbXjk36W2ZI78md3gZiDvYN1Ubl5bCYMO4M59KEKajKjLtHrIpu/7LqR0t9OkVEXaS
         ADSvn0omLpE07LIqJy+CpADAYT0M+JPc6bMFsPndfeMNgrZsEeMssMJW68YS4JunuFmk
         +scVI2LkJs/WsKIQbDLMwT7bu1baMltGUVWV+AYeP492naFHD4jvZ5FzUxmbfHrVMxp/
         6WbIEtLCQZuo/VQ+wy/gehF7yBjIpQoC/AreaiEZ7bSG5guPXXXoTDdV2kCR0OmSyrB4
         rptOHNs4ZbFZ9dC/9JLY/po12bMU6a+N9/2AQvVr8i19zJoLU2vEMEJIVhdGJf4zDXFc
         i/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=umYuaqH/vbuPE2RKme3P+diNf3XB7pJeeiLOBWpjlxQ=;
        b=RRm2F+O2kcCxqf1UJwNACs51/jDmfg9dN/MPC87FA/Rs3z4PwqTBmWsA0/74ImS3UT
         cA+Oemwf/ANWgmm/BwaIhjRREMNfzA1trV5VSgyGCxJaAZHzA5sSsdrz7v3r1I1u2Gp7
         KzSmYjHa6YVGuR+MW1MVUUrOT3uz3R/rnEtdHZ3p5sSJ1PltPzI460eMlFBKpDaX5EuV
         9roT9ZwMtK/V4apXUoKS3sJ8H8moQ0pw1GmQMCTXuB/Gg5iODxQBFHzEKt1OpjFYq5IM
         A4fyqfbwsTm8t8oBHl3aGVBd73DnR6N5WJfxGUK1ouand17uk4Uua8hy1CzH/FUnMUU7
         /X8w==
X-Gm-Message-State: APjAAAXeXAa0qvXdfGYLfvsSqEWHcrHMP4YmNTRXyx5d3LXoMU2An7uB
        TUh4EMhsMu0a1YFMI0aT5feXMA==
X-Google-Smtp-Source: APXvYqxuazx8M6Jgo0s4QPNDTfksqLUO1ArYjoFL+xvFC43QOaCBZoo+WhNmkI3OQ/GA10fktSFlsw==
X-Received: by 2002:a63:4a1a:: with SMTP id x26mr4919608pga.298.1573703402162;
        Wed, 13 Nov 2019 19:50:02 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b82sm4649335pfb.33.2019.11.13.19.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 19:50:01 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:49:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur ??wigo?? <a.swigon@partner.samsung.com>,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] interconnect: Add interconnect_graph file to debugfs
Message-ID: <20191114034958.GB21530@yoga>
References: <70f672b39780ba7387d15fd6485f94b75d47b1ec.1573692109.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f672b39780ba7387d15fd6485f94b75d47b1ec.1573692109.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 13 Nov 16:50 PST 2019, Leonard Crestez wrote:

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

Nice, I like it!

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/interconnect/core.c | 66 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> Example output as a github gist:
> https://gist.github.com/cdleonard/2f74a7efe74587e3d4b57cf7983b46a8
> 
> The qcs404 driver was hacked to probe on imx, the links to "0" seem to
> from incorrect trailing 0s on DEFINE_QNODE. Possibly fallout from
> switching to ARRAY_SIZE(__VA_ARGS__)?
> 
> I'm not sure that "graphviz" is allowed as an output format even in
> debugfs.
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index c498796adc07..07e91288c7f4 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -92,10 +92,74 @@ static int icc_summary_show(struct seq_file *s, void *data)
>  
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(icc_summary);
>  
> +static void icc_graph_show_link(struct seq_file *s, int level,
> +				struct icc_node *n, struct icc_node *m)
> +{
> +	seq_printf(s, "%s\"%d:%s\" -> \"%d:%s\"\n",
> +			level == 2 ? "\t\t" : "\t",
> +			n->id, n->name, m->id, m->name);
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
>  static struct icc_node *node_find(const int id)
>  {
>  	return idr_find(&icc_idr, id);
>  }
>  
> @@ -800,10 +864,12 @@ EXPORT_SYMBOL_GPL(icc_provider_del);
>  static int __init icc_init(void)
>  {
>  	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
>  	debugfs_create_file("interconnect_summary", 0444,
>  			    icc_debugfs_dir, NULL, &icc_summary_fops);
> +	debugfs_create_file("interconnect_graph", 0444,
> +			    icc_debugfs_dir, NULL, &icc_graph_fops);
>  	return 0;
>  }
>  
>  static void __exit icc_exit(void)
>  {
> -- 
> 2.17.1
> 
