Return-Path: <linux-pm+bounces-28861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA7ADBE46
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F105A7A4491
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9011428E7;
	Tue, 17 Jun 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JJRfMCMM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34D78C9C
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750121423; cv=none; b=IlenznfG2W72lCnENJa0C7Ngyi3pA+6ixMkVs+vvx20FIkwC0j7HFpxTF4iAEz8c48J4m2q3iJBwNb03sNRtX+3I0+poD77Q4+VzWpRqqv6EASo+BH/Nv1EkkJC9FjDmnQMiNM9BfYG/lVubXkOoI2216sNNz1jTe2ozsYUyOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750121423; c=relaxed/simple;
	bh=XM/zTY4+hy2hx2K91S0s1R31CAExjH/f0Ow9Qp8GEIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=akfseJJl571DJgEcM2yUt8k68+JnX27sWOy/v66DQYA8QoyRj8sYJwO1uMcIjSpyTWIFQb1IArqy8vqUaU0ZqHHhwYIK1p7cy71hr92jHkwy1zF+zixS7OcgVWjAZ4XuQp+gujY8cKx+b1UjT1U1HW56EteQMox7ceRJVLbc8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JJRfMCMM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2360ff7ac1bso35795035ad.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750121420; x=1750726220; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnJW/sOQY9aQOY/9yftC8CvVAq36qpelS7zJm8mO7Qs=;
        b=JJRfMCMMhtKmbfInHoavMIE5ueOftQomDFSSf1tQ/XmPEn3O3pNjOLafqPSnmKAZ4t
         LUt8NRBM/REeMd6IS72bmnfQQjM7iPOIWhC/dF0hmwoFoTsb1JQDuKse5uKZxXgOlul9
         IwF+F6CT0oM/rh8Ivt/APLa0/Kl1WlD1AnAgMuPhidF7qGPVh0kSOelUwh+tE/6aGnRO
         1cPmsAJvjO+oH9AWwNYeRiE0i8Wyk7zd7DsnUiNAfEg3s5Mwb8B3vVWl8xaGfSeSws54
         hJiF/6P2b3EXzpujKd3g6ndI/JE913g81TMTJBMKf9CX+TVQgKHF4Sj9nMyORs1XPBID
         S3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750121420; x=1750726220;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnJW/sOQY9aQOY/9yftC8CvVAq36qpelS7zJm8mO7Qs=;
        b=Hq5Ind84cJfn7tfYvdg9o0Ccx4Kz9Z5Mf2jLe9yo10sG4folpP+/RDk/OhwY9DZ4l9
         f0yK8ORDmrqyXKmE9i2ZPZIbkaSUYYcNmPF+Zwj4t1AYxt61i4/6nkPatKzV5e82nyqZ
         NKfCVRAvHdddHMptO9KPa1NMg+7q/46RTtPznng348cFOsp8SSwUB+v8uhp6FvGn4ioj
         shI0eIYwT8p9bMxa2m94p1Mpy7lxmUx4DhSE9gnbDK8EhcLL3/b3t0ElI6tGlROzKR8z
         Y6L/H3esqR1cP0xySnrrb2L7S+zSDxJqoinZVN+CZrsKmow9ls6BXnXJ0KnNVObCbjdj
         KZyA==
X-Forwarded-Encrypted: i=1; AJvYcCV91Yiw940ZKkJuZsPDBC4JZvxtTtL1b7SGf6ff8Rh5amD/1Y4Z9B9huraObi0IPPuilENXSit60g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxixkcv+L0+4TKVewieDWYcqDkj5zNmhTCQ14kSA+USKS5bWiYE
	AKI+Y4U3t2w7tz1H0ah5IpNVhfqJcaplJCTYGIjSFSbx73MgFRCT3+GOAUsVWuNVHUo=
X-Gm-Gg: ASbGncsg1jHotgTI3BQdC0gPh7oIXVEzkfVt3BWJUAktIFVVP3ocfPNtoN6SyZe0VOC
	blZ3Jfs4/lbaeNrG4HDtI8IcVaGzdkOIhTVg8i5BVCNkHChprUN7bFdQU2gy1d2vlBKLkpM9jIu
	pCV6oT9dh2JdPbVVLWaTp8sH2cTfinQYnd/hOv14hxARjsq4PlQ5RAGeYlb5ReMYKJK71OhD/No
	oYia6Eq+DSULVNwl5qlooBTDRqU+k1/5iJzr0lBJplJtIEs9RJ3ipeH766UJLsapDRz3cCy6P+l
	zNyW+P1NigLYX0E96ArD82IY3i6tDv9C5qo1Q/78XLat+xzIp8mZNdtv5azm/fyVdgkFIBQ=
X-Google-Smtp-Source: AGHT+IGK53DLu+F+32QwMSMZusoMyF5FfzxpNHKsB04ELuGZaLrGkgIzxJL9Nu6YdwjwU+Ly30E0TA==
X-Received: by 2002:a17:903:943:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-2366afc485bmr167667785ad.1.1750121420437;
        Mon, 16 Jun 2025 17:50:20 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deaa9b8sm67698645ad.165.2025.06.16.17.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:50:19 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
In-Reply-To: <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
 <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
Date: Mon, 16 Jun 2025 17:50:19 -0700
Message-ID: <7hsejzp4xg.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:
--text follows this line--
> On Sat, 14 Jun 2025 at 00:39, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Currently, PM domains can only support hierarchy for simple
>> providers (e.g. ones with #power-domain-cells = 0).
>>
>> Add more generic support for hierarchy by using nexus node
>> maps (c.f. section 2.5.1 of the DT spec.)
>>
>> For example, we could describe SCMI PM domains with multiple parents
>> domains (MAIN_PD and WKUP_PD) like this:
>>
>>     scmi_pds: protocol@11 {
>>         reg = <0x11>;
>>         #power-domain-cells = <1>;
>>
>>         power-domain-map = <15 &MAIN_PD>,
>>                            <19 &WKUP_PD>;
>>     };
>>
>> which should mean that <&scmi_pds 15> is a subdomain of MAIN_PD and
>> <&scmi_pds 19> is a subdomain of WKUP_PD.
>>
>> IOW, given an SCMI device which uses SCMI PM domains:
>>
>>    main_timer0: timer@2400000 {
>>       power-domains = <&scmi_pds 15>;
>>    };
>>
>> it already implies that main_timer0 is PM domain <&scmi_pds 15>
>>
>> With the new map, this *also* now implies <&scmi_pds 15> is a
>> subdomain of MAIN_PD.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/core.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index d6c1ddb807b2..adf022b45d95 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -2998,8 +2998,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>                                  unsigned int index, unsigned int num_domains,
>>                                  bool power_on)
>>  {
>> -       struct of_phandle_args pd_args;
>> -       struct generic_pm_domain *pd;
>> +       struct of_phandle_args pd_args, parent_args;
>> +       struct generic_pm_domain *pd, *parent_pd = NULL;
>>         int ret;
>>
>>         ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>> @@ -3039,6 +3039,22 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>                         goto err;
>>         }
>>
>> +       /*
>> +        * Check for power-domain-map, which implies the primary
>> +        * power-doamin is a subdomain of the parent found in the map.
>> +        */
>> +       ret = of_parse_phandle_with_args_map(dev->of_node, "power-domains",
>> +                                            "power-domain", index, &parent_args);
>> +       if (!ret && (pd_args.np != parent_args.np)) {
>> +               parent_pd = genpd_get_from_provider(&parent_args);
>> +               of_node_put(parent_args.np);
>> +
>> +               ret = pm_genpd_add_subdomain(parent_pd, pd);
>> +               if (!ret)
>> +                       dev_dbg(dev, "adding PM domain %s as subdomain of %s\n",
>> +                               pd->name, parent_pd->name);
>> +       }
>
> Please move the above new code to a separate shared genpd helper
> function, that genpd providers can call build the topology. This, to
> be consistent with the current way for how we usually add
> parent/child-domains in genpd (see of_genpd_add_subdomain).

Yeah, you had the same comment on v2, and I'm not ignoring you.  But I
thought that moving this code to when devices are attatched to domains
(instead of when providers are created) would solve that problem.  IOW,
in this approach, `power-domain-map` is handled at the same time as a
devices `power-domains = ` property.

So, while I don't really understand the reason that every PM domain
provider has to handle this individually, I've given that a try (see
below.)

> Moreover, we also need a corresponding "cleanup" helper function to
> remove the child-domain (subdomain) correctly, similar to
> of_genpd_remove_subdomain().

Yes, I'll handle that better once I get through this RFC phase to make
sure I'm on th right path.

OK, so below[1] is a shot at just adding helpers to the PM domain core.  I
will then uses these from the SCMI PM domains ->attach_dev() and
->detatch_dev callbacks.

If you think this is better, I'll send a v4 tomorrow.

Kevin

[1] NOTE: this is based on v6.12 because that's where I have a functioning BSP
for this SoC.  If you're OK with this, I'll rebase to v6.15 and submit upstream.

From 12a3e5669dc18f4a9fdf9f25398cba4245135a43 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 13 Jun 2025 13:49:45 -0700
Subject: [PATCH 2/3] pmdomain: core: add support for subdomains via
 power-domain-map

---
 drivers/pmdomain/core.c   | 60 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h | 11 +++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 88819659df83..a0dc60d4160d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3100,6 +3100,66 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
 	return genpd_dev_pm_attach_by_id(dev, index);
 }
 
+/**
+ * genpd_dev_pm_attach_subdomain - Associate a PM domain with its parent domain
+ * @domain: The PM domain to lookup whether it has any parent
+ * @dev: The device being attached to the PM domain.
+ *
+ * Check if @domain has a power-domain-map.  If present, use that map
+ * to determine the parent PM domain, and attach @domain as a
+ * subdomain to the parent PM domain.
+ *
+ * Intended to called from a PM domain provider's ->attach_dev()
+ * callback, where &gpd_list_lock will already be held by the genpd
+ * add_device() path.
+ */
+struct generic_pm_domain *
+genpd_dev_pm_attach_subdomain(struct generic_pm_domain *domain,
+			      struct device *dev)
+{
+	struct of_phandle_args parent_args;
+	struct generic_pm_domain *parent_pd = NULL;
+	int ret;
+
+	/*
+	 * Check for power-domain-map, which implies the primary
+	 * power-doamin is a subdomain of the parent found in the map.
+	 */
+	ret = of_parse_phandle_with_args_map(dev->of_node, "power-domains",
+					     "power-domain", 0, &parent_args);
+	if (!ret && parent_args.np) {
+		parent_pd = genpd_get_from_provider(&parent_args);
+		of_node_put(parent_args.np);
+
+		ret = genpd_add_subdomain(parent_pd, domain);
+		if (!ret) {
+			dev_dbg(dev, "adding PM domain %s as subdomain of %s\n",
+				domain->name, parent_pd->name);
+			return parent_pd;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_subdomain);
+
+/**
+ * genpd_dev_pm_detach_subdomain - Detatch a PM domain from its parent domain
+ * @domain: The PM subdomain to detach
+ * @parent: The parent PM domain
+ * @dev: The device being attached to the PM subdomain.
+ *
+ * Remove @domain from @parent.
+ * Intended to cleanup after genpd_dev_pm_attach_subdomain()
+ */
+int genpd_dev_pm_detach_subdomain(struct generic_pm_domain *domain,
+				  struct generic_pm_domain *parent,
+				  struct device *dev)
+{
+	return pm_genpd_remove_subdomain(parent, domain);
+}
+EXPORT_SYMBOL_GPL(genpd_dev_pm_detach_subdomain);
+
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
 	{ }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index cf4b11be3709..5d7eb3ae59dd 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -410,6 +410,11 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 					   const char *name);
+struct generic_pm_domain *genpd_dev_pm_attach_subdomain(struct generic_pm_domain *domain,
+							struct device *dev);
+int genpd_dev_pm_detach_subdomain(struct generic_pm_domain *domain,
+				  struct generic_pm_domain *parent,
+				  struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -466,6 +471,12 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 	return NULL;
 }
 
+static inline
+struct generic_pm_domain *genpd_dev_pm_attach_subdomain(struct generic_pm_domain *domain,
+							struct device *dev)
+{
+	return NULL;
+}
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-- 
2.49.0



